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
            .sink(receiveCompletion: { _ in }) { (posts) in
                if !posts.isEmpty {
                    self.page += 1
                }
                withAnimation {
                    self.postFeed.append(contentsOf: posts)
                }
            }
    }
    
    func createPost(post: PostRequest) {
        cancellable = SocialSettingAPI.createPost(post: post)
            .print()
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.postFeed.insert($0, at: 0)
                self.createPostIsPresented = false
            })
    }
    
    func deletePost() {
        guard let post = deletablePost else { return }
        cancellable = SocialSettingAPI.delete(post: post)
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
