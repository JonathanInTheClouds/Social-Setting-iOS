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
        let userDefaults = UserDefaults.standard
        var selectedSubSettingName = ""
        
        do {
            let savedSubSetting = try userDefaults.getObject(forKey: "SelectedSubSetting", castTo: SubSettingResponse.self)
            selectedSubSettingName = savedSubSetting.name
        } catch {
            guard let username = SocialSettingAPI.agent.savedAuthentication?.username else { return Fail(error: NetworkError.decodingFailed).eraseToAnyPublisher() }
            selectedSubSettingName = username
        }
        var request = URLRequest(url: url.appendingPathComponent("subSetting/\(selectedSubSettingName)/post"))
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

