//
//  PostViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/29/20.
//

import Foundation
import Combine

class PostViewModel: BaseAuth, ObservableObject {
    
    private var postCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        postCancellable?.cancel()
    }
    
    func likePost(post: PostResponseModel) {
        print("Attempting to \(post.upVote ? "UPVOTE" : "DOWNVOTE")")
        guard let authToken = token else { return }
        let likeData: [String : Any] = ["postId": post.id, "voteType": "\(post.upVote ? "UPVOTE" : "DOWNVOTE")"]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: likeData, options: .prettyPrinted) else { return }
        component.path = "/api/vote"
        guard let url = component.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Bearer": authToken, "Accept":"application/json", "Content-Type":"application/json"]
        request.httpBody = jsonData
        
        postCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (element) -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else { throw URLError(.badServerResponse) }
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { (response) in
                print(response)
            } receiveValue: { (data) in
                print(data)
            }

    }
    
    
}
