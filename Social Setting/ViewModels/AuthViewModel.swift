//
//  AuthViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/19/20.
//

import Foundation
import SwiftKeychainWrapper

class AuthViewModel: AuthNetworkProtocol, ObservableObject {
    
    @Published var secureCodeValidated: Bool = false
    
    @Published var validationConfirmed: Bool = false
    
    @Published var opacity: Double = 0
    
    
    /// Sends sign in request to server
    /// - Parameters:
    ///   - signInRequest: Package material for request
    ///   - completion: Result type of AuthResponseModel or URLError
    func signIn(signInRequest: SignInRequestModel, completion: @escaping (Result<AuthResponseModel, URLError>) -> ()) {
        
        var component = self.component
        component.path = "/api/auth/login"
        
        guard let url = component.url else {
            completion(.failure(.init(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        guard let jsonData = try? JSONEncoder().encode(signInRequest) else {
            completion(.failure(.init(.cannotDecodeRawData)))
            return
        }
        
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                completion(.failure(.init(.badServerResponse)))
                return
            }
            
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                // Sort By Status Code
                completion(.failure(.init(.userAuthenticationRequired)))
                return
            }
            
            guard let authResponse = try? JSONDecoder.decoder.decode(AuthResponseModel.self, from: data) else {
                completion(.failure(.init(.cannotDecodeRawData)))
                return
            }
            
            print(authResponse)
            
            if self.saveTokens(with: authResponse) {
                completion(.success(authResponse))
            } else {
                completion(.failure(.init(.cannotWriteToFile)))
            }
            
        }.resume()
        
    }
    
    /// Sends sign up request to server
    /// - Parameters:
    ///   - signUpRequest: Package material for request
    ///   - completion: Result type of Void or URLError
    func signUp(signUpRequest: SignUpRequestModel, completion: @escaping (Result<Void, URLError>) -> ()) {
        var component = self.component
        component.path = "/api/auth/signup"
        
        guard let url = component.url else { return completion(.failure(.init(.badURL))) }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let signUpData = try? JSONEncoder().encode(signUpRequest) else { return }
        
        request.httpBody = signUpData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                print("Response = \(response)")
                // Sort By Status Code
                switch response.statusCode {
                case (409):
                    guard let networkRespError = try? JSONDecoder.decoder.decode(NetworkResponseError.self, from: data) else {
                        completion(.failure(.init(.cannotDecodeRawData)))
                        return
                    }
                    completion(.failure(networkRespError.message == "Email" ? .emailConflictError : .userConflictError))
                default:
                    completion(.failure(.init(.badServerResponse)))
                }
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
        
    }
    
    /// Sends validation code to server
    /// - Parameters:
    ///   - code: Validation code number
    ///   - completion: Result type of AuthResponseModel or URLError
    func validateSecureCode(code: Int, completion: @escaping (Result<AuthResponseModel, URLError>) -> ()) {
        var component = self.component
        component.path = "/api/auth/token/verify/code"
        guard let url = component.url else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let parameters: [String:Int] = ["code": code]
        
        guard let secureCodePackage = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else { fatalError("Invalid URL") }
        
        request.httpBody = secureCodePackage
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(.init(.badServerResponse)))
                return
            }
            
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                print("Response = \(response)")
                // Sort By Status Code
                completion(.failure(.init(.userAuthenticationRequired)))
                return
            }
            
            guard let authResponse = try? JSONDecoder.decoder.decode(AuthResponseModel.self, from: data) else {
                completion(.failure(.init(.cannotDecodeRawData)))
                return
            }
            
            if self.saveTokens(with: authResponse) {
                completion(.success(authResponse))
            } else {
                completion(.failure(.init(.badServerResponse)))
            }
            
        }.resume()
           
    }
    
    
    private func handle409(data: Data) -> URLError {
        guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else { return .init(.badURL) }
        let message = result["message"]
        if message == "Email" {
            return .emailConflictError
        }
        return .userConflictError
    }
    
}
