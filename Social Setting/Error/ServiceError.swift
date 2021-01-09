//
//  ServiceError.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation

struct ServiceError: Decodable, Error {
    let errors: [ServiceErrorMessage]
}
