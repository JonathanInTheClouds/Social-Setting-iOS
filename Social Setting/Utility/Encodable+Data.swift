//
//  Encodable+Data.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import Foundation

extension Encodable {
    func toData() -> Data {
        guard let data = try? JSONEncoder().encode(self) else { preconditionFailure("Failed Encoding") }
        return data
    }
}
