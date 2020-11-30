//
//  AuthResponseModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import Foundation

struct AuthResponseModel: Codable {
    let publicId: String
    let authenticationToken: String
    let refreshToken: String
    let expiresAt: ExpiresAt
    let username: String
    var profileName: String?
}

struct ExpiresAt: Codable {
    let nano: Int
    let epochSecond: Int
}
