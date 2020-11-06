//
//  RefreshTokenRequestModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/30/20.
//

import Foundation

struct RefreshTokenRequestModel: Encodable {
    let refreshToken: String
    let publicId: String
}
