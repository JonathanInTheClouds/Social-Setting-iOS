//
//  PostResponse.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/3/21.
//

import Foundation

struct PostResponse: Codable {
    let subSettingId: Int64
    let postId: Int64
    let postName: String
    var description: String
    var url: String?
    let userPublicId: String
    var username: String
    let subSettingName: String
    var voteCount: Int
    var commentCount: Int
    let duration: String
    var upVote: Bool
    var downVote: Bool
    var deleted: Bool? = false
}
