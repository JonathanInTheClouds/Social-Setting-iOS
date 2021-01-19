//
//  CommentPopupHelper.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/19/21.
//

import Foundation

class CommentPopupHelper: ObservableObject {
    
    @Published var shouldReply = false
    
    @Published var commentRequestHelper = CommentRequestHelper()

    
}
