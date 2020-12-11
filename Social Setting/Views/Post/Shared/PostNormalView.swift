//
//  NormalPostView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI

struct PostNormalView: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        VStack(alignment: .leading) {
            PostHeadView(username: post.username, timeAgo: post.duration)
            MainBody(bodyText: post.description)
                .foregroundColor(Color.gray99)
                .padding(.bottom, 15)
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Color.gray39
                .frame(height: 1, alignment: .center)
            PostButtonHStack(post: $post)
        }
    }
}


private struct MainBody: View {
    
    var bodyText: String
    
    var photoURL: String?
    
    
    var body: some View {
        VStack {
            Text(bodyText)
                .font(setFont(text: bodyText))
            if photoURL == nil { // Temp
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("placeholder-photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180, alignment: .center)
                        .cornerRadius(6)
                        .clipped()
                })
            }
        }
    }
    
    func setFont(text: String) -> Font? {
        if text.count <= 50 {
            return .title
        }
        
        if text.count <= 80 {
            return .title2
        }
        
        return .title3
    }
}



struct NormalPostView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostNormalView(post: .constant(PostResponseModel(id: 1, postName: "Openly admit that you don't know something", url: nil,
                                                         description: "If you don't have any knowledge about the topic, admit it openly that you don't know.", username: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false, voteCount: 61, commentCount: 147)))
    }
}
