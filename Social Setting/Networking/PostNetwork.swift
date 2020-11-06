//
//  PostNetwork.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/4/20.
//

import Foundation
import Combine

class PostNetwork: AuthNetworkProtocol {
    
    func createPost(from postRequest: PostRequestModel) -> AnyPublisher<PostResponseModel, Error> {
        var component = self.component
        component.path = "/api/post"
        guard let auth = authentication,
              let postRequestJSON = try? JSONEncoder().encode(postRequest),
              let url = component.url
        else { return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher() }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Bearer": auth.authenticationToken, "Accept":"application/json", "Content-Type":"application/json"]
        request.httpBody = postRequestJSON
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (element) -> Data in
                print(element)
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 201 else { throw URLError(.badServerResponse) }
                return element.data
            }
            .decode(type: PostResponseModel.self, decoder: JSONDecoder.decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func likePost(with post: PostResponseModel) {
        let likeData: [String : Any] = ["postId": post.id, "voteType": "\(post.upVote ? "UPVOTE" : "DOWNVOTE")"]
        var component = self.component
        component.path = "/api/vote"
        guard let auth = authentication,
              let jsonData = try? JSONSerialization.data(withJSONObject: likeData, options: .prettyPrinted),
              let url = component.url
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Bearer": auth.authenticationToken, "Accept":"application/json", "Content-Type":"application/json"]
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data,
                  let response = response as? HTTPURLResponse, error == nil,
                  (200...299) ~= response.statusCode
            else {
                self.refreshToken { self.likePost(with: post) }
                return
            }
        }.resume()
    }
    
}
