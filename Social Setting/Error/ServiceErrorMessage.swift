//
//  ServiceErrorMessage.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation

enum ServiceErrorMessage: String, Decodable, Error {
    case invalidToken = "invvalid_token"
}
