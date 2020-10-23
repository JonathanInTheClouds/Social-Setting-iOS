//
//  AuthViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/19/20.
//

import Foundation
import SwiftKeychainWrapper

class AuthViewModel: ObservableObject {
    
    @Published var secureCodeValidated: Bool = false
    
    @Published var validationConfirmed: Bool = false
    
    @Published var opacity: Double = 0
    
    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "auth_token")
        }
    }
    
    
    private let decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func signIn(signInRequest: SignInRequestModel, completion: @escaping (Result<AuthResponseModel, NetworkError>) -> ()) {
        guard let url = URL(string: "http://localhost:8086/api/auth/signin") else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        guard let jsonData = try? JSONEncoder().encode(signInRequest) else {
            completion(.failure(.badPackage))
            return
        }
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                completion(.failure(.clientError))
                return
            }
            
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                // Sort By Status Code
                completion(.failure(.unAuthorized))
                return
            }
            
            guard let authResponse = try? self.decoder.decode(AuthResponseModel.self, from: data) else {
                completion(.failure(.unAuthorized))
                return
            }
            
            print(authResponse)
            
            if self.saveTokens(authResponse: authResponse) {
                completion(.success(authResponse))
            } else {
                completion(.failure(.clientError))
            }
            
        }
        
        task.resume()
        
    }
    
    func signUp(signUpRequest: SignUpRequestModel, completion: @escaping (Result<Void, NetworkError>) -> ()) {
        
        guard let url = URL(string: "http://localhost:8086/api/auth/signup") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let signUpData = try? JSONEncoder().encode(signUpRequest) else { return }
        
        request.httpBody = signUpData
        
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            
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
                    guard let networkRespError = try? self.decoder.decode(NetworkResponseError.self, from: data) else {
                        completion(.failure(.conflictError))
                        return
                    }
                    completion(.failure(networkRespError.message == "Email" ? .emailConflictError : .userConflictError))
                default:
                    completion(.failure(.serverError))
                }
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
        
    }
    
    func validateSecureCode(code: Int, completion: @escaping (Result<AuthResponseModel, NetworkError>) -> ()) {
        guard let url = URL(string: "http://localhost:8086/api/auth/token/secureCodeVerification") else { fatalError("Invalid URL") }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let parameters: [String:Int] = ["code": code]
        
        guard let secureCodePackage = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else { fatalError("Invalid URL") }
        
        request.httpBody = secureCodePackage
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                print("Response = \(response)")
                // Sort By Status Code
                completion(.failure(.unAuthorized))
                return
            }
            
            guard let authResponse = try? self.decoder.decode(AuthResponseModel.self, from: data) else {
                completion(.failure(.serverError))
                return
            }
            
            if self.saveTokens(authResponse: authResponse) {
                completion(.success(authResponse))
            } else {
                completion(.failure(.serverError))
            }
            
        }
        
        task.resume()
        
        
    }
    
    func sendProfileData(profileName: String, completion: @escaping (Result<Void, NetworkError>) -> ()) {
        guard let authToken = KeychainWrapper.standard.string(forKey: "auth_token") else {
            completion(.failure(.invalidToken))
            return
        }
        
        guard let url = URL(string: "http://localhost:8086/api/user/update") else {
            completion(.failure(.badURL))
            return
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: [
            "profileName": profileName
        ]) else {
            completion(.failure(.badURL))
            return
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpBody = jsonData
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

        let headers = [
            "content-type": "application/json",
            "Bearer": authToken
        ]
        
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                print("error", error ?? "Unknown error")
                completion(.failure(.serverError))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                print("Response = \(response)")
                // Sort By Error 409
                switch response.statusCode {
                default:
                    completion(.failure(.serverError))
                }
                return
            }
            
            print(response.statusCode)
            print(data)
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
    private func handle409(data: Data) -> NetworkError {
        guard let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else { return .badURL }
        let message = result["message"]
        if message == "Email" {
            return .emailConflictError
        }
        return .userConflictError
    }

    private func saveTokens(authResponse: AuthResponseModel) -> Bool {
        let didSaveAuthToken = KeychainWrapper.standard.set(authResponse.authenticationToken, forKey: "auth_token")
        let didSaveRefreshToken = KeychainWrapper.standard.set(authResponse.refreshToken, forKey: "refresh_token")
        return didSaveAuthToken && didSaveRefreshToken
    }
}
