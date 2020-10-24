//
//  TopicPostView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI

struct TopicPostView: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        VStack(alignment: .leading) {
            PostHeadView(username: post.userName, timeAgo: post.duration)
                .padding(.bottom, 10)
            MainBody(post: $post)
            Color.gray39
                .frame(height: 1, alignment: .center)
                .padding(.top, 15)
            ButtonHStack(post: $post)
        }
    }
}

struct TopicPostView_Previews: PreviewProvider {
    static var previews: some View {
        TopicPostView(post: .constant(PostResponseModel(id: 1, publicUserId: "", postName: "Openly admit that you don't know something", url: nil,
                                                        description: "If you don't have any knowledge about the topic, admit it openly that you don't know.", userName: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false, voteCount: 61, commentCount: 147)))
            .padding(.horizontal, 16)
    }
}


private struct MainBody: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        // TODO: - Remove Range Block
        if post.url != nil {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image("placeholder-photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180, alignment: .center)
                    .cornerRadius(6)
                    .clipped()
            })
        }
        
        Text(post.postName)
            .bold()
            .font(.system(size: 24))
            .foregroundColor(Color.gray99)
            .padding(.bottom, 10)
            .fixedSize(horizontal: false, vertical: true)
        
        Text(post.description)
            .font(.system(size: 16))
            .foregroundColor(Color.gray99)
    }
}
