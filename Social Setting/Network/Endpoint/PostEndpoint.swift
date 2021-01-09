//
//  PostEndpoint.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import Foundation
import Combine

extension SocialSettingAPI {
    static func likePost(post: PostResponse) -> AnyPublisher<Void, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let path = "subSetting/\(post.subSettingName)/post/\(post.postId)/vote"
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpBody = VoteRequest(voteType: post.upVote ? "UPVOTE" : "DOWNVOTE").toData()
        request.httpMethod = "POST"
        return agent.onewayAuthenticatedRun(request)
            .map({$0})
            .eraseToAnyPublisher()
    }
    
    static func createPost(post: PostRequest) -> AnyPublisher<PostResponse, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        var request = URLRequest(url: url.appendingPathComponent("subSetting/Software Engineers/post"))
        request.httpBody = post.toData()
        request.httpMethod = "POST"
        return agent.authenticatedRun(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func delete(post: PostResponse) -> AnyPublisher<Void, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let path = "subSetting/\(post.subSettingName)/post/\(post.postId)"
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = "DELETE"
        return agent.onewayAuthenticatedRun(request)
            .map({$0})
            .eraseToAnyPublisher()
    }
}

