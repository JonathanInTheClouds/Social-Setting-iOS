//
//  NetworkSession.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation
import Combine

protocol NetworkSession: AnyObject {
    func publisher(for request: URLRequest, token: AuthenticationResponse?) -> AnyPublisher<Data, Error>
}
