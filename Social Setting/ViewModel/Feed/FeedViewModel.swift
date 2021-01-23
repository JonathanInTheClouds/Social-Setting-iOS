//
//  FeedViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import Foundation
import Combine
import SwiftUI

class FeedViewModel: ObservableObject, AuthTokenProtocol {
    
    @Published var postFeed = [PostResponse]()
    
    @Published var createPostIsPresented = false
    
    @Published var showActionSheet = false
    
    @Published var deleted = false
    
    var deletablePost: PostResponse?
    
    private var page = 0
    
    private var cancellable: AnyCancellable?
    
    deinit {
        print("FeedViewModel Killed - ☠️")
    }
    
    func getFeed() {
        cancellable = SocialSettingAPI.getMainFeed(of: page)
            .sink(receiveCompletion: { _ in }) { [weak self] posts in
                if !posts.isEmpty {
                    self?.page += 1
                }
                self?.postFeed.append(contentsOf: posts)
            }
    }
    
    func createPost(post: PostRequest) {
        cancellable = SocialSettingAPI.createPost(post: post)
            .print()
            .sink(receiveCompletion: { _ in 
                self.createPostIsPresented = false
            }, receiveValue: { [weak self] post in
                withAnimation(.spring()) {
                    self?.postFeed.insert(post, at: 0)
                }
            })
    }
    
    func deletePost() {
        guard let post = deletablePost else { return }
        cancellable = SocialSettingAPI.delete(post: post)
            .print()
            .sink(receiveCompletion: { _ in }) {
                for (index, element) in self.postFeed.enumerated() {
                    if element.postId == self.deletablePost?.postId {
                        withAnimation {
                            self.postFeed[index].deleted = true
                            self.deletablePost = nil
                        }
                    }
                }
            }
    }
    
    func setDeletablePost(post: PostResponse) {
        self.deletablePost = post
    }
}
