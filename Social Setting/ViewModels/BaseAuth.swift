//
//  BaseAuth.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/23/20.
//

import Foundation
import SwiftKeychainWrapper

class BaseAuth {
    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "auth_token")
        }
    }
    
    var isTokenExpired: Bool {
        get {
            guard let data = KeychainWrapper.standard.string(forKey: "expires_At") else { return true }
            guard let expireDate = data.toDate() else { return true }
            return Date() >= expireDate
        }
    }
    
    let decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
