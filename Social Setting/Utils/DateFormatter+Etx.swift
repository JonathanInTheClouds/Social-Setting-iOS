//
//  DateFormatter+Etx.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/3/20.
//

import Foundation

extension DateFormatter {
    static let formattedDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
}
