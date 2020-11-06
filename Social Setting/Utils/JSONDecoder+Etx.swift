//
//  JSONDecoder+Etx.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/3/20.
//

import Foundation

extension JSONDecoder {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.formattedDate)
        return decoder
    }()
}
