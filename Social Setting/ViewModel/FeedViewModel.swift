//
//  FeedViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/27/21.
//

import SwiftUI
import LoremSwiftum

class FeedViewModel: ObservableObject {
    
    @Published var postArray = (1...50).map { (_) -> PostModel in
        PostModel(name: "\(Lorem.firstName)", username: Lorem.lastName, timeAgo: "\(Int.random(in: 1...9))h ago", liked: false, bookMarked: false, likes: Int.random(in: 1...420), comments: Int.random(in: 1...420), details: Lorem.tweet, postType: .photo)
    }
    
}
