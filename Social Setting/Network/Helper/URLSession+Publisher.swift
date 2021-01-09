//
//  URLSession+Publisher.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation
import Combine

extension URLSession: NetworkSession {
    func publisher(for request: URLRequest, token: AuthenticationResponse?) -> AnyPublisher<Data, Error> {
        guard let mutableRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else { return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher() }
        if let token = token {
            mutableRequest.setValue("Bearer \(token.authenticationToken)", forHTTPHeaderField: "Authorization")
            mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            mutableRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        return dataTaskPublisher(for: mutableRequest as URLRequest)
            .tryMap { (result) in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      200 ... 299 ~= httpResponse.statusCode else {
                    let error = try JSONDecoder().decode(ServiceError.self, from: result.data)
                    print("Error ==>> \(result.response)")
                    throw error
                }
                return result.data
            }
            .eraseToAnyPublisher()
    }
}

