//
//  NetworkRouter.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import Foundation
import Combine

enum NetworkRouter {
    static let apiClient = APIClient()
    static let baseURL = URL(string: "http://localhost:8080/api")
}

extension NetworkRouter {
    func signUp(signUpRequest: SignUpRequest) -> AnyPublisher<Bool, Error> {
        
        
    }
}
