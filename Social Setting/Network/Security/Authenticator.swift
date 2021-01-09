//
//  Authenticator.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation
import Combine
import SwiftKeychainWrapper

class Authenticator: AuthTokenProtocol {
    private let session: NetworkSession
    private let queue = DispatchQueue(label: "Autenticator.\(UUID().uuidString)")
    private var refreshPublisher: AnyPublisher<AuthenticationResponse, Error>?
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func validToken(forceRefresh: Bool = false) -> AnyPublisher<AuthenticationResponse, Error> {
        return queue.sync { [weak self] in
            if let publisher = self?.refreshPublisher {
                return publisher
            }
            
            guard let token = self?.savedAuthentication else {
                return Fail(error: AuthenticationError.loginRequired)
                    .eraseToAnyPublisher()
            }
            
            if token.isValid(), !forceRefresh {
                return Just(token)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            
            guard let url = SocialSettingAPI.base.url?.appendingPathComponent("auth/token/refresh") else {
                return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
            }
            var request = URLRequest(url: url)
            request.httpBody = token.toData()
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let publisher = session.publisher(for: request, token: nil)
                .print()
                .share()
                .decode(type: AuthenticationResponse.self, decoder: JSONDecoder())
                .tryMap({ (token) -> AuthenticationResponse in
                    KeychainWrapper.standard.removeAllKeys()
                    KeychainWrapper.standard.set(token.toData(), forKey: "authentication")
                    return token
                })
                .handleEvents(receiveCompletion: { _ in
                    self?.queue.sync {
                        self?.refreshPublisher = nil
                    }
                })
                .eraseToAnyPublisher()
            
            self?.refreshPublisher = publisher
            print("Attempted Token Refresh")
            return publisher
        }
    }
    
}
