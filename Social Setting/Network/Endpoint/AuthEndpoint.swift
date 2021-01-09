//
//  AuthenticationAPI.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/3/21.
//

import Foundation
import Combine

extension SocialSettingAPI {
    
    static func signIn(signInRequest: SignInRequest) -> AnyPublisher<AuthenticationResponse, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        var request = URLRequest(url: url.appendingPathComponent("auth/login"))
        request.httpMethod = "POST"
        request.httpBody = signInRequest.toData()
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        return agent.run(request)
            .map({ $0.value })
            .eraseToAnyPublisher()
    }
    
    static func signUp(signUpRequest: SignUpRequest) -> AnyPublisher<SignUpResponse, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        var request = URLRequest(url: url.appendingPathComponent("auth/signup"))
        request.httpMethod = "POST"
        request.httpBody = signUpRequest.toData()
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func verifyCode(verifyCodeRequest: VerifyCodeRequest) -> AnyPublisher<AuthenticationResponse, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        var request = URLRequest(url: url.appendingPathComponent("auth/token/verify/code/"))
        request.httpMethod = "POST"
        request.httpBody = verifyCodeRequest.toData()
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
}
