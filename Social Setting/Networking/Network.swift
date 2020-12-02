//
//  Network.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/27/20.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badAuth
}

class Network: BaseNetworkProtocol {
    
    static let shared = Network()
    
    private init() {}
    
}
