//
//  SelectedPostViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/4/20.
//

import Foundation
import Combine

class PostDetailViewModel: ObservableObject {
    
    @Published var comments = [CommentResponseModel]()
    
    @Published var post: PostResponseModel
    
    init(post: PostResponseModel) {
        self.post = post
    }
    
    private var page = 0
    
    private var feedCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        feedCancellable?.cancel()
    }
    
    func fetchFeed() {
        feedCancellable = Network.shared.getCommentFeed(id: post.id, page: page)
            .sink(receiveCompletion: { (response) in
                print(response)
            }, receiveValue: { (postDetails) in
                print(postDetails)
                self.comments.append(contentsOf: postDetails.comments)
                guard let post = postDetails.post else { return }
                self.post = post
            })
    }
    
}
