//
//  Auth.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/4/20.
//

import Foundation
import SwiftKeychainWrapper

protocol AuthNetworkProtocol {}

extension AuthNetworkProtocol {
    
    var authentication: AuthResponseModel? {
        guard let data = KeychainWrapper.standard.data(forKey: "authentication") else { return nil }
        return try? JSONDecoder.decoder.decode(AuthResponseModel.self, from: data)
    }
    
    var isTokenExpired: Bool {
        get {
            guard let data = KeychainWrapper.standard.string(forKey: "expires_At") else { return true }
            print(data)
            guard let expireDate = data.toDate() else { return true }
            return Date() < expireDate
        }
    }
    
    var component: URLComponents {
        var component = URLComponents()
        component.scheme = "http"
        component.host = "localhost"
        component.port = 8080
        return component
    }
    
    /// Saves Authentication Token to Device for futher use
    /// - Parameter authResponse: packaged auth data
    /// - Returns: true on success
    func saveTokens(with authResponse: AuthResponseModel) -> Bool {
        guard let data = try? JSONEncoder.encoder.encode(authResponse) else { return false }
        return KeychainWrapper.standard.set(data, forKey: "authentication")
    }
    
    
    /// Deletes  Token from Device
    func deleteTokens() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
    
    /// Refreshes Authentication Token for futher use
    /// - Parameter run: funtion that is to be continued after refresh
    func refreshToken(then run: @escaping () -> ()) {
        var component = self.component
        component.path = "/api/auth/token/refresh"
        guard let url = component.url,
              let auth = authentication,
              let jsonData = try? JSONSerialization.data(withJSONObject: ["refreshToken": auth.refreshToken, "publicId": auth.publicId ], options: .prettyPrinted)
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                  let response = response as? HTTPURLResponse, error == nil,
                  (200...299) ~= response.statusCode,
                  let authResponse = try? JSONDecoder.decoder.decode(AuthResponseModel.self, from: data)
            else { return }
            self.deleteTokens()
            if self.saveTokens(with: authResponse) {
                run()
            }
        }.resume()
    }
    
}
