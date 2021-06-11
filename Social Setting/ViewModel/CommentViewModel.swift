//
//  CommentViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/27/21.
//

import SwiftUI
import LoremSwiftum

class CommentViewModel: ObservableObject {
    @Published var commentsArray = (1...Int.random(in: 1...10)).map { (int) -> CommentModel in
        CommentModel(user: UserModel(name: Lorem.firstName, username: Lorem.firstName, subTitle: Lorem.word, bio: Lorem.sentences(1)), text: Lorem.shortTweet, timeAgo: "2h")
    }
    
    init() {
        print("Created")
    }
    
    deinit {
        print("Killed")
    }
}
