//
//  FeedViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/23/20.
//

import Foundation
import SwiftUI
import SwiftKeychainWrapper
import Combine

class FeedViewModel: ObservableObject {
    
    @Published var postFeed:[PostResponseModel] = [PostResponseModel]()
    
    @Published var createPostIsPresented: Bool = false
    
    @Published var shoudShowMenu: Bool = false
    
    private var currentPage: Int = 0
    
    private var feedCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        feedCancellable?.cancel()
    }
    
    
    /// Gets main feed
    func fetchFeed() {
        feedCancellable = Network.shared.getFeed(by: currentPage)
            .sink(receiveCompletion: { (response) in
                switch response {
                case .finished:
                    print(response)
                case .failure(_):
                    Network.shared.refreshToken(then: self.fetchFeed)
                }
            }, receiveValue: { (listOfPost) in
                if !listOfPost.isEmpty {
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.postFeed.append(contentsOf: listOfPost)
                        self.currentPage += 1
                    }
                }
            })
    }
    
    
    /// Removes post from server
    /// - Parameter post: Package material for request
    func deletePost(post: PostResponseModel) {
        Network.shared.deletePost(id: post.id)
        guard let index = postFeed.firstIndex(of: post) else { return }
        postFeed.remove(at: index)
    }
    
}
