//
//  FeedViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/27/21.
//

import SwiftUI
import LoremSwiftum

class FeedViewModel: ObservableObject {
    
    @Published var postArray = (1...50).map { (int) -> PostModel in
        PostModel(user: UserModel(name: Lorem.firstName, username: Lorem.firstName, subTitle: Lorem.word, bio: Lorem.sentences(1)), timeAgo: "\(Int.random(in: 1...9))h ago", liked: false, bookMarked: false, likes: Int.random(in: 1...420), comments: Int.random(in: 1...420), text: Lorem.tweet, postType: int % 2 == 0 ? .share : .regular)
    }
    
}
