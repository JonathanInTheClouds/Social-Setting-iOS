//
//  CommentFeedResponse.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/13/21.
//

import Foundation

struct CommentFeedResponse: Decodable {
    var post: PostResponse? = nil
    var comments: [CommentResponse]
}
