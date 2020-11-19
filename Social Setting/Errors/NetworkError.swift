//
//  NetworkError.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/21/20.
//

import Foundation

extension URLError {
    static var userConflictError = URLError.init(.badServerResponse)
    static var emailConflictError  = URLError.init(.badServerResponse)
}
