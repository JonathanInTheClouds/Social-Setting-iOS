//
//  FeedViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/23/20.
//

import Foundation
import SwiftKeychainWrapper
import Combine

class FeedViewModel: BaseAuth, ObservableObject {
    
    @Published var postFeed:[PostResponseModel] = [PostResponseModel]()
    
    private var feedService: FeedService = FeedService()
    
    private var currentPage: Int = 1
    
    private var feedCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    override init() {
        super.init()
        fetchFeed()
    }
    
    deinit {
        feedCancellable?.cancel()
    }
    
    func fetchFeed() {
        guard let authToken = token else { return }
        component.path = "/api/post/feed"
        component.queryItems = [URLQueryItem(name: "page", value: "\(currentPage)")]
        guard let url = component.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Bearer": authToken, "Accept":"application/json", "Content-Type":"application/json"]
        
        feedCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (element) -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data
            })
            .decode(type: [PostResponseModel].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { response in
                print(response)
            } receiveValue: { (newPost) in
                if !newPost.isEmpty {
                    self.postFeed.append(contentsOf: newPost)
                    self.currentPage += 1
                }
            }
    }
    
}
