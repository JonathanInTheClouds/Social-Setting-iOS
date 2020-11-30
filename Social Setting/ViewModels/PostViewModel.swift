//
//  PostViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/29/20.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    /// Sends like status to server
    /// - Parameter post: Package material for request
    func likePost(post: PostResponseModel) {
        Network.shared.likePost(with: post)
    }
    
    /// Sends post to server
    /// - Parameters:
    ///   - postRequest: Package material for request
    ///   - then: Package material for response
    func createPost(postRequest: PostRequestModel, then: @escaping (PostResponseModel) -> ()) {
        Network.shared.createPost(postRequest: postRequest, completion: then)
    }
    
}
