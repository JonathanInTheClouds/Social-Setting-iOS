//
//  Post.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/14/20.
//

import SwiftUI

struct PostContentView: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            Group {
                if post.postName.isEmpty {
                    NormalPostView(post: $post)
                } else {
                    TopicPostView(post: $post)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 10)
            
        }
    }
}

struct Post_Previews: PreviewProvider {
    
    static var previews: some View {
        PostContentView(post: .constant(PostResponseModel(id: 1,
                                                          postName: "Openly admit that you don't know something", url: nil,
                                                          description: "If you don't have any knowledge about the topic, admit it openly that you don't know.",
                                                          username: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false,
                                                          voteCount: 61, commentCount: 147)))
    }
}

