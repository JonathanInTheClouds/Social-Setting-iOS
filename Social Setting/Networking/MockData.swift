//
//  MockData.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/10/20.
//

import Foundation

class MockData {
    static var posts: [PostResponseModel] = [
        PostResponseModel(id: 1,
                          postName: "Openly admit that you don't know something", url: nil,
                          description: "If you don't have any knowledge about the topic, admit it openly that you don't know.",
                          username: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false,
                          voteCount: 61, commentCount: 147)
    ]
}
