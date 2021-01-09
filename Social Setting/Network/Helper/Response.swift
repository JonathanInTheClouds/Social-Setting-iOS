//
//  Response.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
}
