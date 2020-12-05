//
//  PostDetailResponseModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/4/20.
//

import Foundation

struct PostDetailResponseModel: Decodable {
    
    var post: PostResponseModel?
    
    var comments = [CommentResponseModel]()
    
    func fetch() {
        
    }
    
}
