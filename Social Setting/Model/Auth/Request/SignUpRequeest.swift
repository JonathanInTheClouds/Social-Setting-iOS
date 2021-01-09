//
//  SignUpRequeest.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import Foundation

struct SignUpRequest: Encodable {
    let email: String
    let username: String
    let profileName: String
    let password: String
}

