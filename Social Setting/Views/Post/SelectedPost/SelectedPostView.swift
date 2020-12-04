//
//  OpenPostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/29/20.
//

import SwiftUI

struct SelectedPostView: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        ZStack {
            Color.tertiarySystemBackground
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    VStack(alignment: .leading) {
                        PostHeadView(username: post.username, timeAgo: post.duration)
                        TopicMainBody(post: $post)
                            .padding(.vertical, 16)
                        ButtonHStack(post: $post)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 25)
                }
            }
        }
    }
}

struct OpenPostView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPostView(post: .constant(PostResponseModel(id: 1, postName: "Openly admit that you don't know something", url: nil, description: "If you don't have any knowledge about the topic, admit it openly that you don't know.", username: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false, voteCount: 61, commentCount: 147)))
    }
}
