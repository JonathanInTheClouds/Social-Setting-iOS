//
//  FeedNetwork.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/4/20.
//

import Foundation
import Combine

class FeedNetwork: AuthNetworkProtocol {

    func getFeed(from page: Int) -> AnyPublisher<[PostResponseModel], Error> {
        var component = self.component
        component.path = "/api/post/feed"
        component.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        guard let authentication = authentication,
              let url = component.url else {
            return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Bearer": authentication.authenticationToken, "Accept":"application/json", "Content-Type":"application/json"]
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
    
    
    
}
