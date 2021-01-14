//
//  LoginViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import Foundation
import Combine
import SwiftKeychainWrapper

class AuthViewModel: ObservableObject, AuthTokenProtocol {
    
    @Published var authentication: AuthenticationResponse?
    
    @Published var sucessfullySignedUp: Bool = false
    
    private var cancellable: AnyCancellable?
    
    deinit {
        print("AuthViewModel Killed - ☠️")
    }
    
    func signIn(signinRequest: SignInRequest) {
        cancellable = SocialSettingAPI.signIn(signInRequest: signinRequest)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.saveAuthToken($0) })
    }
    
    func signUp(signUpRequest: SignUpRequest) {
        cancellable = SocialSettingAPI.signUp(signUpRequest: signUpRequest)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.sucessfullySignedUp = $0.valid })
    }
    
    func verifyCode(verifyCodeRequest: VerifyCodeRequest) {
        cancellable =  SocialSettingAPI.verifyCode(verifyCodeRequest: verifyCodeRequest)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.saveAuthToken($0) })
    }
    
    func getSubSettingFeed(_ page: Int) {
        cancellable = SocialSettingAPI.getSubSettingFeed(page)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
    
    func signOut() {
        authentication = nil
        KeychainWrapper.standard.removeAllKeys()
    }
    
    fileprivate func saveAuthToken(_ authResponse: AuthenticationResponse) {
        guard let data = try? JSONEncoder().encode(authResponse) else { preconditionFailure("Shit") }
        KeychainWrapper.standard.set(data, forKey: "authentication")
        self.authentication = authResponse
    }
    
}


extension Subscribers.Completion {
    func error() throws -> Failure {
        if case let .failure(error) = self {
            return error
        }
        throw ErrorFunctionThrowsError.error
    }
    private enum ErrorFunctionThrowsError: Error { case error }
}
