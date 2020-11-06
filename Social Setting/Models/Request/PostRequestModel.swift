//
//  PostRequestModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/23/20.
//

import Foundation


struct PostRequestModel: Encodable {
    let postName: String
    let description: String
    let isProfilePost: Bool
}
