//
//  NetworkError.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameters encoding failed."
    case missingURL = "URL is nil"
    case badURL = "Bad URL"
}
