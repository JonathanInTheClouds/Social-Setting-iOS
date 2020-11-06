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
    
    @Published var showingActionSheet: Bool = false
    
    private let feedNetwork = FeedNetwork()
    
    private var currentPage: Int = 1
    
    private var feedCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        feedCancellable?.cancel()
    }
    
    func fetchFeed() {
        feedCancellable = feedNetwork.getFeed(from: currentPage)
            .sink { response in
                switch response {
                case .finished:
                    print(response)
                case .failure(_):
                    self.feedNetwork.refreshToken(then: self.fetchFeed)
                }
            } receiveValue: { (newPost) in
                if !newPost.isEmpty {
                    withAnimation(.easeIn(duration: 0.2)) {
                        self.postFeed.append(contentsOf: newPost)
                        self.currentPage += 1
                    }
                }
            }
    }
    
}
