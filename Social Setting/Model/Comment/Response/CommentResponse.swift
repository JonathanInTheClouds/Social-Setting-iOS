//
//  CommentResponse.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/13/21.
//

import Foundation

struct CommentResponse: Decodable {
    let id: Int64
    let postId: Int64
    let text: String
    let username: String
    let duration: String
}
