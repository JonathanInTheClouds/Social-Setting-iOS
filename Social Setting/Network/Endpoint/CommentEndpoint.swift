//
//  CommentEndpoint.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/13/21.
//

import Foundation
import Combine

extension SocialSettingAPI {
    static func getComments(subSettingName: String, postId: Int64, page: Int) -> AnyPublisher<CommentFeedResponse, Error> {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"),
                          URLQueryItem(name: "amount", value: "\(20)"),
                          URLQueryItem(name: "info", value: "true")]
        var urlComponent = base
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let request = URLRequest(url: url.appendingPathComponent("subSetting/\(subSettingName)/post/\(postId)/comment"))
        return agent.authenticatedRun(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
