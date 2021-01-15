//
//  Network.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/14/21.
//

import Foundation
import Combine

class Network {
    
    private init() {}
    
    static let shared = Network()
    
    var agent = NetworkManager()
    
    var base: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "192.168.1.25"
        components.path = "/api"
        components.port = 8086
        return components
    }
    
    func signIn(signInRequest: SignInRequest) -> AnyPublisher<AuthenticationResponse, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        var request = URLRequest(url: url.appendingPathComponent("auth/login"))
        request.httpMethod = "POST"
        request.httpBody = signInRequest.toData()
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        return agent.run(request)
            .map({ $0.value })
            .eraseToAnyPublisher()
    }
    
    func signUp(signUpRequest: SignUpRequest) -> AnyPublisher<SignUpResponse, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        var request = URLRequest(url: url.appendingPathComponent("auth/signup"))
        request.httpMethod = "POST"
        request.httpBody = signUpRequest.toData()
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func verifyCode(verifyCodeRequest: VerifyCodeRequest) -> AnyPublisher<AuthenticationResponse, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        var request = URLRequest(url: url.appendingPathComponent("auth/token/verify/code/"))
        request.httpMethod = "POST"
        request.httpBody = verifyCodeRequest.toData()
        request.allHTTPHeaderFields = ["Accept":"application/json", "Content-Type":"application/json"]
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func getMainFeed(of page: Int) -> AnyPublisher<[PostResponse], Error> {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "amount", value: "\(20)")]
        var urlComponent = base
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let request = URLRequest(url: url.appendingPathComponent("user/feed"))
        return agent.authenticatedRun(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func getSubSettingFeed(_ page: Int) -> AnyPublisher<SubSettingFeedResponse, Error> {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        var urlComponent = base
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let request = URLRequest(url: url.appendingPathComponent("subSetting/CS Students"))
        return agent.authenticatedRun(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func likePost(_ post: PostResponse) -> AnyPublisher<Void, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let path = "subSetting/\(post.subSettingName)/post/\(post.postId)/vote"
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpBody = VoteRequest(voteType: post.upVote ? "UPVOTE" : "DOWNVOTE").toData()
        request.httpMethod = "POST"
        return agent.onewayAuthenticatedRun(request)
            .map({$0})
            .eraseToAnyPublisher()
    }
    
    func createPost(_ post: PostRequest) -> AnyPublisher<PostResponse, Error> {
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
    
    func deletePost(_ post: PostResponse) -> AnyPublisher<Void, Error> {
        guard let url = base.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let path = "subSetting/\(post.subSettingName)/post/\(post.postId)"
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = "DELETE"
        return agent.onewayAuthenticatedRun(request)
            .map({$0})
            .eraseToAnyPublisher()
    }
    
    func getSubscribedSubsettingList(page: Int) -> AnyPublisher<[SubSettingResponse], Error> {
        let queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "amount", value: "\(20)")]
        var urlComponent = base
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return Fail(error: NetworkError.badURL).eraseToAnyPublisher() }
        let request = URLRequest(url: url.appendingPathComponent("subSetting/subscribed"))
        return agent.authenticatedRun(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func getComments(subSettingName: String, postId: Int64, page: Int) -> AnyPublisher<CommentFeedResponse, Error> {
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
