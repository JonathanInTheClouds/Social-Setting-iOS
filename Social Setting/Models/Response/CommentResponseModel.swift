//
//  CommentResponseModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/4/20.
//

import Foundation

struct CommentResponseModel: Codable {
    let id: Int
    let postId: Int
    let text: String
    let username: String
    let duration: String
}
