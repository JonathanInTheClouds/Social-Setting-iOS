//
//  SubSettingResponse.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/3/21.
//

import Foundation

struct SubSettingResponse: Codable, Identifiable {
    let id: Int64
    let name: String
    let description: String
    let numberOfPost: Int64
}
