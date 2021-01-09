//
//  PostRequest.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import Foundation

struct PostRequest: Encodable {
    let postName: String
    let url: String?
    let description: String
}
