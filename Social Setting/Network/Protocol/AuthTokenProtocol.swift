//
//  BaseAuthProtocol.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/2/21.
//

import Foundation
import SwiftKeychainWrapper

protocol AuthTokenProtocol {}

extension AuthTokenProtocol {
    var savedAuthentication: AuthenticationResponse? {
        guard let data = KeychainWrapper.standard.data(forKey: "authentication") else { return nil }
        return try? JSONDecoder().decode(AuthenticationResponse.self, from: data)
    }
}
