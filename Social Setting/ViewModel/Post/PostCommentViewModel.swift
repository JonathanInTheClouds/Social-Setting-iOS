//
//  PostCommentViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/13/21.
//

import Foundation
import Combine

class PostCommentViewModel: ObservableObject {
    
    var page: Int = 0
    
    var commentFeedCancellable: AnyCancellable?
    
    func getComments(subSettingName: String, postId: Int64, completion: @escaping ([CommentResponse]) -> Void) {
        commentFeedCancellable = SocialSettingAPI.getComments(subSettingName: subSettingName, postId: postId, page: page)
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                completion($0.comments)
            })
    }
    
    func createComment(subSettingName: String, postId: Int, text: String, completion: @escaping (Result<CommentResponse, Error>) -> Void) {
        commentFeedCancellable = SocialSettingAPI.createComment(subSettingName: subSettingName, postId: postId, text: text)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished: break
                case .failure(_):
                    completion(.failure(APIError.somethingWentWrong))
                }
            }, receiveValue: {
                completion(.success($0))
            })
    }
    
}
