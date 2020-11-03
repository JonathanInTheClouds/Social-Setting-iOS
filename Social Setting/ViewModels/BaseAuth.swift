//
//  BaseAuth.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/23/20.
//

import Foundation
import SwiftKeychainWrapper
import Combine

class BaseAuth {
    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "auth_token")
        }
    }
    
    var refreshToken: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "refresh_token")
        }
    }
    
    var publicId: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "publicId")
        }
    }
    
    var isTokenExpired: Bool {
        get {
            guard let data = KeychainWrapper.standard.string(forKey: "expires_At") else { return true }
            print(data)
            guard let expireDate = data.toDate() else { return true }
            return Date() < expireDate
        }
    }
    
    private var cancellable: AnyCancellable? {
        didSet { oldValue?.cancel() }
    }
    
    var component: URLComponents = {
        var component = URLComponents()
        component.scheme = "http"
        component.host = "192.168.1.36"
        component.port = 8086
        return component
    }()
    
    let decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func refreshAuthToken(then run: @escaping () -> ()) {
        component.path = "/api/auth/token/refresh"
        guard let url = component.url else { return }
        guard let refreshToken = refreshToken else { return }
        guard let publicId = publicId else { return }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: ["refreshToken": refreshToken, "publicId": publicId ], options: .prettyPrinted) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (element) -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data
            }
            .decode(type: AuthResponseModel.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { (response) in
                switch response {
                case .finished:
                    run()
                case .failure(_):
                    print(response)
                }
            } receiveValue: { (authResponseModel) in
                self.deleteTokens()
                let _ = self.saveTokens(authResponse: authResponseModel)
            }
    }
    
    func saveTokens(authResponse: AuthResponseModel) -> Bool {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let expiryDate = df.string(from: authResponse.expiresAt)
        let didSaveAuthToken = KeychainWrapper.standard.set(authResponse.authenticationToken, forKey: "auth_token")
        let didSaveRefreshToken = KeychainWrapper.standard.set(authResponse.refreshToken, forKey: "refresh_token")
        let didSaveExpireDate = KeychainWrapper.standard.set(expiryDate, forKey: "expires_At")
        let didSavePublicId = KeychainWrapper.standard.set(authResponse.publicId, forKey: "publicId")
        let didSaveUsername = KeychainWrapper.standard.set(authResponse.username, forKey: "username")
        return didSaveAuthToken && didSaveRefreshToken && didSaveExpireDate && didSavePublicId && didSaveUsername
    }
    
    func deleteTokens() {
        let _ = KeychainWrapper.standard.remove(forKey: "auth_token")
        let _ = KeychainWrapper.standard.remove(forKey: "refresh_token")
        let _ = KeychainWrapper.standard.remove(forKey: "expires_At")
        let _ = KeychainWrapper.standard.remove(forKey: "publicId")
        let _ = KeychainWrapper.standard.remove(forKey: "username")
        KeychainWrapper.standard.removeAllKeys()
    }
}
