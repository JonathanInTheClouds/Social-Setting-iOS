//
//  UserProfileResponse.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/9/20.
//

import Foundation

class UserProfileResponseModel: Codable {
    let username: String
    let email: String
    let description: String?
    let url: String?
    var postCount: Int
    var followerCount: Int
    var followingCount: Int
}
