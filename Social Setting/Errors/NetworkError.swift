//
//  NetworkError.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/21/20.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badPackage
    case conflictError
    case userConflictError
    case emailConflictError
    case unAuthorized
    case invalidToken
    case expiredToken
    case serverError
    case clientError
}
