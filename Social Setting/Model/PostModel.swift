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
    let name: String
    let username: String
    let timeAgo: String
    var liked: Bool
    var bookMarked: Bool
    var likes: Int
    var comments: Int
    let details: String
    let postType: PostType
}

enum PostType {
    case regular, photo, repost
}

var posts = [
    PostModel(name: "Joshua Lawrance", username: "joshua_l", timeAgo: "2h ago", liked: false, bookMarked: false, likes: 420, comments: 16, details: "I recently understood the words of my friend Jacob West about music.", postType: .photo),
    PostModel(name: "\(Lorem.firstName)", username: Lorem.lastName, timeAgo: "\(Int.random(in: 1...9))h ago", liked: false, bookMarked: false, likes: Int.random(in: 1...420), comments: Int.random(in: 1...420), details: Lorem.tweet, postType: .regular)
]


