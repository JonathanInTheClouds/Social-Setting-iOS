//
//  Router.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/1/21.
//

import Foundation

enum Router {
    case signUp(signUpRequest: SignUpRequest)
    case signIn
    
    var scheme: String {
        switch self {
        case .signIn, .signUp:
            return "http"
        }
    }
    
    var host: String {
        switch self {
        case .signIn, .signUp:
            return "localhost:8080/api"
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/auth/login"
        case .signUp:
            return "/auth/signup"
        }
    }
    
    
}
