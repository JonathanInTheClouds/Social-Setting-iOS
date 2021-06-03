//
//  PostModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/27/21.
//

import Foundation
import SwiftUI
import LoremSwiftum

struct PostModel: Hashable {
    let user: UserModel
    let timeAgo: String
    var liked: Bool
    var bookMarked: Bool
    var likes: Int
    var comments: Int
    let text: String
    let postType: PostType
}

enum PostType {
    case regular, photo, share
}

var posts = [
    PostModel(user: UserModel(name: Lorem.firstName, username: Lorem.firstName, subTitle: Lorem.word, bio: Lorem.sentences(1)), timeAgo: "2h ago", liked: false, bookMarked: false, likes: 420, comments: 16, text: "I recently understood the words of my friend Jacob West about music.", postType: .regular),
    PostModel(user: UserModel(name: Lorem.firstName, username: Lorem.firstName, subTitle: Lorem.word, bio: Lorem.sentences(1)), timeAgo: "2h ago", liked: false, bookMarked: false, likes: 420, comments: 16, text: "I recently understood the words of my friend Jacob West about music.", postType: .regular),
    PostModel(user: UserModel(name: Lorem.firstName, username: Lorem.firstName, subTitle: Lorem.word, bio: Lorem.sentences(1)), timeAgo: "2h ago", liked: false, bookMarked: false, likes: 420, comments: 16, text: "I recently understood the words of my friend Jacob West about music.", postType: .regular)
]


