//
//  PostCommentViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/13/21.
//

import Foundation
import Combine

class PostCommentViewModel: ObservableObject {
    
    @Published var commentList = [CommentResponse]()
    
    var page: Int = 0
    
    var commentFeedCancellable: AnyCancellable?
    
    func getComments(subSettingName: String, postId: Int64, completion: @escaping ([CommentResponse]) -> Void) {
        commentFeedCancellable = SocialSettingAPI.getComments(subSettingName: subSettingName, postId: postId, page: page)
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                completion($0.comments)
            })
    }
    
}
