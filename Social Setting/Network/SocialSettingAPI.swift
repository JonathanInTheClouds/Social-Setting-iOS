//
//  SocialSettingAPI.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/1/21.
//

import Foundation
import Combine
import SwiftKeychainWrapper

enum SocialSettingAPI {
    
    static var agent = NetworkManager()
    
    static var base: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "192.168.1.25"
        components.path = "/api"
        components.port = 8086
        return components
    }
    
    
}

