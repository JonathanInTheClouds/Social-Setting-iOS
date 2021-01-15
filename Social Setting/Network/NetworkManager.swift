//
//  NetworkAgent.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/1/21.
//

import Foundation
import Combine
import SwiftKeychainWrapper

struct NetworkManager: AuthTokenProtocol {
    
    private let session: NetworkSession
    private let authenticator: Authenticator
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
        self.authenticator = Authenticator(session: session)
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      200 ... 299 ~= httpResponse.statusCode else { throw APIError.unauth }
                print(httpResponse.statusCode)
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func authenticatedRun<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        guard let authentication = savedAuthentication else { return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher() }
        guard let mutableRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else { return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher() }
        let header = ["Authorization": "Bearer \(authentication.authenticationToken)", "Accept":"application/json", "Content-Type":"application/json"]
        mutableRequest.allHTTPHeaderFields = header
        return authenticator.validToken()
            .flatMap { (_) in
                session.publisher(for: mutableRequest as URLRequest, token: savedAuthentication)
            }
            .tryCatch { (error) -> AnyPublisher<Data, Error> in
                guard let serviceError = error as? ServiceError,
                      serviceError.errors.contains(ServiceErrorMessage.invalidToken) else {
                    throw error
                }
                return authenticator.validToken(forceRefresh: true)
                    .flatMap { (token) in
                        session.publisher(for: mutableRequest as URLRequest, token: token)
                    }
                    .eraseToAnyPublisher()
            }
            .tryMap({ (result: Data) -> Response<T> in
                guard let value = try? JSONDecoder().decode(T.self, from: result) else {
                    throw URLError(URLError.Code.cannotDecodeRawData)
                }
                return Response(value: value, response: URLResponse())
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func onewayAuthenticatedRun(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Void, Error> {
        guard let authentication = savedAuthentication else { return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher() }
        guard let mutableRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else { return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher() }
        let header = ["Authorization": "Bearer \(authentication.authenticationToken)", "Accept":"application/json", "Content-Type":"application/json"]
        mutableRequest.allHTTPHeaderFields = header
        return authenticator.validToken()
            .flatMap { (_) in
                session.publisher(for: mutableRequest as URLRequest, token: savedAuthentication)
            }
            .tryCatch { (error) -> AnyPublisher<Data, Error> in
                guard let serviceError = error as? ServiceError,
                      serviceError.errors.contains(ServiceErrorMessage.invalidToken) else {
                    throw error
                }
                return authenticator.validToken(forceRefresh: true)
                    .flatMap { (token) in
                        session.publisher(for: mutableRequest as URLRequest, token: token)
                    }
                    .eraseToAnyPublisher()
            }
            .tryMap({ _ in
                return Void()
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case userIsOffline
    case somethingWentWrong
    case unauth
}
