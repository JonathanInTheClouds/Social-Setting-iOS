//
//  FeedNetworking.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/27/20.
//

import Foundation
import Combine

extension Network {
    
    /// Gets main feed data from server
    /// - Parameter page: Current page of feed
    /// - Returns: AnyPublisher with array of PostResponseModel
    func getFeed(by page: Int) -> AnyPublisher<[PostResponseModel], Error> {
        var component = self.component
        component.path = "/api/user/feed"
        component.queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "amount", value: "10")]
        guard let authentication = authentication,
              let url = component.url else {
            return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Authorization": "Bearer \(authentication.authenticationToken)", "Accept":"application/json", "Content-Type":"application/json"]
        request.allHTTPHeaderFields = header
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (element) -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data
            })
            .decode(type: [PostResponseModel].self, decoder: JSONDecoder.decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /// Get profile feed data from server
    /// - Parameters:
    ///   - username: Target username
    ///   - page: Current page of feed
    /// - Returns: AnyPublisher  of UserProfileFeedResponseModel
    func getProfileFeed(username: String, page: Int) -> AnyPublisher<UserProfileFeedResponseModel, Error> {
        var component = self.component
        component.path = "/api/user/\(username)/profile"
        component.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "amount", value: "10"),
            URLQueryItem(name: "profileInfo", value: "\(true)")
        ]
        guard let authentication = authentication,
              let url = component.url else {
            return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Authorization": "Bearer \(authentication.authenticationToken)", "Accept":"application/json", "Content-Type":"application/json"]
        request.allHTTPHeaderFields = header
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (responseData) -> Data in
                guard let httpResponse = responseData.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return responseData.data
            }
            .decode(type: UserProfileFeedResponseModel.self, decoder: JSONDecoder.decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
