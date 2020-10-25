//
//  FeedService.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/24/20.
//

import Foundation
import Combine

final class FeedService: BaseAuth {
    func fetchFeed(page: Int) -> AnyPublisher<[PostResponseModel], Error> {
        guard let authToken = token else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        guard let url = URL(string: "http://localhost:8086/api/post/feed?page=\(page)") else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let headers = ["Bearer": authToken, "Accept":"application/json", "Content-Type":"application/json"]
        
        request.allHTTPHeaderFields = headers
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (element) -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data
            })
            .decode(type: [PostResponseModel].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
