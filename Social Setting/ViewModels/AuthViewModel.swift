//
//  AuthViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/19/20.
//

import Foundation
import SwiftKeychainWrapper
import SwiftUI

class AuthViewModel: BaseNetworkProtocol, ObservableObject {
    
    @Published var secureCodeValidated: Bool = false
    
    @Published var validationConfirmed: Bool = false
    
    @Published var opacity: Double = 1
    
    
    /// Sends sign in request to server
    /// - Parameters:
    ///   - signInRequest: Package material for request
    ///   - completion: Result type of AuthResponseModel or URLError
    func signIn(signInRequest: SignInRequestModel) {
        Network.shared.signIn(signInRequest: signInRequest) { (result) in
            switch result {
            case .success(_):
                withAnimation { 
                    self.opacity = 0
                }
            case .failure(let reason):
                print(result)
                print(reason)
            }
        }
    }
    
    /// Sends sign up request to server
    /// - Parameters:
    ///   - signUpRequest: Package material for request
    ///   - completion: Result type of Void or URLError
    func signUp(signUpRequest: SignUpRequestModel, completion: @escaping (Result<Void, URLError>) -> ()) {
        Network.shared.signUp(signUpRequest: signUpRequest, completion: completion)
    }
    
    /// Sends validation code to server
    /// - Parameters:
    ///   - code: Validation code number
    ///   - completion: Result type of AuthResponseModel or URLError
    func validateSecureCode(code: Int, completion: @escaping (Result<AuthResponseModel, URLError>) -> ()) {
        Network.shared.validateSecureCode(code: code, completion: completion)
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
