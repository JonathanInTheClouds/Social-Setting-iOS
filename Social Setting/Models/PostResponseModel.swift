//
//  PostModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/23/20.
//

import Foundation

struct PostResponseModel: Decodable, Hashable {
    var localId: UUID? = UUID()
    let id: Int
    let publicUserId: String
    let postName: String
    let url: String?
    let description: String
    let userName: String
    let subSettingName: String
    let duration: String
    var upVote: Bool
    var downVote: Bool
    var voteCount: Int
    var commentCount: Int
}
