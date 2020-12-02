//
//  AuthNetworking.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/2/20.
//

import Foundation

extension Network {
    func signIn(signInRequest: SignInRequestModel, completion: @escaping (Result<AuthResponseModel, URLError>) -> Void) {
        var component = self.component
        component.path = "/api/auth/login"
        guard let signInData = try? JSONEncoder().encode(signInRequest), let url = component.url else {
            return completion(.failure(URLError(.badURL))) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = signInData
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                return
            }
            
            guard let authResponse = try? JSONDecoder.decoder.decode(AuthResponseModel.self, from: data) else {
                return completion(.failure(URLError(.cannotDecodeRawData)))
            }
            
            if self.saveTokens(with: authResponse) {
                completion(.success(authResponse))
            } else {
                completion(.failure(URLError(.unknown)))
            }
            
        }.resume()
    }
    
    func signUp(signUpRequest: SignUpRequestModel, completion: @escaping (Result<Void, URLError>) -> Void) {
        var component = self.component
        component.path = "/api/auth/signup"
        guard let signUpData = try? JSONEncoder().encode(signUpRequest), let url = component.url else {
            return completion(.failure(URLError(.badURL))) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = signUpData
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                return
            }
            
            completion(.success(()))
            
        }.resume()
    }
    
    func validateSecureCode(code: VerificationCodeModel, completion: @escaping (Result<AuthResponseModel, URLError>) -> Void) {
        var component = self.component
        component.path = "/api/auth/signup"
        guard let signUpData = try? JSONEncoder().encode(code), let url = component.url else {
            return completion(.failure(URLError(.badURL))) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = signUpData
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                return
            }
            
            guard let authResponse = try? JSONDecoder.decoder.decode(AuthResponseModel.self, from: data) else {
                return completion(.failure(URLError(.cannotDecodeRawData)))
            }
            
            if self.saveTokens(with: authResponse) {
                completion(.success(authResponse))
            } else {
                completion(.failure(URLError(.unknown)))
            }
            
        }.resume()
    }
}
