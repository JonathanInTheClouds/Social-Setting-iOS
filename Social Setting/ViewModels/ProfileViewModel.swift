//
//  ProfileViewModel.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/28/20.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject, BaseNetworkProtocol {
    
    @Published var profilePost: [PostResponseModel] = [PostResponseModel]()
    
    @Published var username: String = ""
    
    @Published var email: String = ""
    
    @Published var description: String? = ""
    
    @Published var url: String? = ""
    
    @Published var postCount: Int = 0
    
    @Published var followerCount: Int = 0
    
    @Published var followingCount: Int = 0
    
    private var page: Int = 0
    
    
    
    private var feedCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    
    /// Gets profile data
    /// - Parameter username: Target username
    func fetchProfileData(username: String) {
        feedCancellable = Network.shared.getProfileFeed(username: username, page: page)
            .sink { (response) in
                print(response)
            } receiveValue: { (data) in
                if let profileInfo = data.profile {
                    self.username = profileInfo.username
                    self.email = profileInfo.email
                    self.description = profileInfo.description
                    self.url = profileInfo.url
                    self.postCount = profileInfo.postCount
                    self.followerCount = profileInfo.followerCount
                    self.followingCount = profileInfo.followingCount
                }
                if data.posts.count > 0 {
                    self.profilePost.append(contentsOf: data.posts)
                    self.page += 1
                }
            }
    }
    
    
}
