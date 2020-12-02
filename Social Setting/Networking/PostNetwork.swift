//
//  PostNetworking.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/27/20.
//

import Foundation
import Combine

extension Network {
    
    /// Sends post to server
    /// - Parameters:
    ///   - postRequest: package material for request
    ///   - completion: packaged response from server
    /// - Returns: void
    func createPost(postRequest: PostRequestModel, completion: @escaping (PostResponseModel) -> ()) {
        guard let auth = authentication else { return }
        var component = self.component
        print(auth.username)
        component.path = "/api/subSetting/\(auth.username)/post"
        guard let postRequestJSON = try? JSONEncoder().encode(postRequest),
              let url = component.url
        else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(auth.authenticationToken)", "Accept":"application/json", "Content-Type":"application/json"]
        request.httpBody = postRequestJSON
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                return
            }
            guard let createdPost = try? JSONDecoder.decoder.decode(PostResponseModel.self, from: data) else { return }
            DispatchQueue.main.async { completion(createdPost) }
        }.resume()
    }
    
    /// Sends delete request to server
    /// - Parameter id: Post Id for deletion
    func deletePost(id: Int) {
        var component = self.component
        component.path = "/api/subSetting/a/post/id/\(id)"
        guard let url = component.url, let auth = authentication else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(auth.authenticationToken)", "Accept":"application/json", "Content-Type":"application/json"]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let _ = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            guard (200...299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                return
            }
            
            print("Delete \(response.statusCode)")
        }.resume()
    }
    
    /// Send like to server
    /// - Parameter post: Package material for request
    func likePost(with post: PostResponseModel) {
        let likeData: [String : Any] = ["postId": post.id, "voteType": "\(post.upVote ? "UPVOTE" : "DOWNVOTE")"]
        var component = self.component
        component.path = "/api/subSetting/\(post.subSettingName)/post/id/\(post.id)/vote"
        guard let auth = authentication,
              let jsonData = try? JSONSerialization.data(withJSONObject: likeData, options: .prettyPrinted),
              let url = component.url
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let header = ["Authorization": "Bearer \(auth.authenticationToken)", "Accept":"application/json", "Content-Type":"application/json"]
        request.allHTTPHeaderFields = header
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
