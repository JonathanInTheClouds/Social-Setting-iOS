//
//  SubSettingFeedEndpoint.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/4/21.
//

import Foundation
import Combine

extension SocialSettingAPI {
    static func getSubSettingFeed(_ page: Int) -> AnyPublisher<SubSettingFeedResponse, Error> {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        var urlComponent = base
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let request = URLRequest(url: url.appendingPathComponent("subSetting/CS Students"))
        return agent.authenticatedRun(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
