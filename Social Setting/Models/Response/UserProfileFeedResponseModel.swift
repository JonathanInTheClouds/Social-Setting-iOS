//
//  UserProfileFeedResponseModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/28/20.
//

import Foundation

struct UserProfileFeedResponseModel: Decodable {
    var profile: UserProfileResponseModel?
    var posts: [PostResponseModel]
}
