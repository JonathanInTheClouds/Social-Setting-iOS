//
//  PostViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/29/20.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    private let postNetwork = PostNetwork()
    
    private var postCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        print("Destroyed CreatePostViewModel")
        postCancellable?.cancel()
    }
    
    func likePost(post: PostResponseModel) {
        postNetwork.likePost(with: post)
    }
    
    func createPost(postRequest: PostRequestModel, completion: @escaping (PostResponseModel) -> ()) {
        
        postCancellable = postNetwork.createPost(from: postRequest)
            .sink { (response) in
                switch response {
                case .finished:
                    print("Post Sent! 🚀")
                case .failure(_):
                    self.postNetwork.refreshToken {
                        self.createPost(postRequest: postRequest, completion: completion)
                    }
                }
            } receiveValue: { (createdPost) in
                print("Post \(createdPost.id) Created:")
                print(createdPost)
                completion(createdPost)
            }

    }
    
}
