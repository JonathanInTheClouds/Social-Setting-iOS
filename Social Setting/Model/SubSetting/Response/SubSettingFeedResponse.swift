//
//  SubSettingFeedResponse.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/3/21.
//

import Foundation

struct SubSettingFeedResponse: Codable {
    var subSettingInfo: SubSettingResponse?
    var posts: [PostResponse]
}
