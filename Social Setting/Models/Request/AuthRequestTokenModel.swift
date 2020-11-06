//
//  AuthRequestTokenModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/3/20.
//

import Foundation

struct AuthRequestTokenModel: Encodable {
    let refreshToken: String
    let publicId: String
}
