//
//  RefreshTokenRequest.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/3/21.
//

import Foundation

struct RefreshTokenRequest: Encodable {
    let refreshToken: String
    let publicId: String
}
