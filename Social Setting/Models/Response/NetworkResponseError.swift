//
//  NetworkResponseError.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/21/20.
//

import Foundation

class NetworkResponseError: Decodable {
    let time: Date
    let message: String
}
