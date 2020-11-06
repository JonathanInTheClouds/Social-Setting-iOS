//
//  JSONEncoder+Etx.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/3/20.
//

import Foundation

extension JSONEncoder {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.formattedDate)
        return encoder
    }()
}
