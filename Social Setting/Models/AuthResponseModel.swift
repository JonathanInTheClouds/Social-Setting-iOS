//
//  AuthResponseModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import Foundation

struct AuthResponseModel: Codable {
    let publicID: String
    let authenticationToken: String
    let refreshToken: String
    let expiresAt: Date
    let username: String
    var profileName: String?
}
