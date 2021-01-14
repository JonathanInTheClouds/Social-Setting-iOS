//
//  PostViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    
    deinit {
        print("PostViewModel Killed - ☠️")
    }
    
    func likePost(post: PostResponse) {
        cancellable = SocialSettingAPI.likePost(post: post)
            .sink(receiveCompletion: { _ in }) { _ in }
    }
}
