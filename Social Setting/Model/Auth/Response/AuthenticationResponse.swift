//
//  AuthenticationResponse.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation

struct AuthenticationResponse: Codable {
    
    let publicId: String
    let authenticationToken: String
    let refreshToken: String
    let expiresAt: AuthExpireAt
    let username: String
    let profileName: String
    
    struct AuthExpireAt: Codable {
        let nano: Int64
        let epochSecond: Int64
    }
    
    
    func toData() -> Data {
        guard let data = try? JSONEncoder().encode(self) else { preconditionFailure("Shit") }
        return data
    }
    
    func isValid() -> Bool {
        let currentTime = Date().timeIntervalSince1970
        let expireTime = TimeInterval(expiresAt.epochSecond)
        return expireTime > currentTime
    }
}
