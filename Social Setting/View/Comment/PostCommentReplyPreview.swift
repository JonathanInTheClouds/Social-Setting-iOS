//
//  PostCommentReplyPreview.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/18/21.
//

import SwiftUI

struct PostCommentReplyPreview: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var post: PostResponse?
    
    var body: some View {
        DynamicBackground(Edge.Set.horizontal, 16, color: colorScheme == .dark ? Color.tertiarySystemBackground : Color.gray19) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "arrow.turn.down.right")
                    
                    Text(post?.username ?? "")
                    
                    HStack {
                        Image(systemName: "suit.heart.fill")
                        Text("\(post?.voteCount ?? 0)")
                    }
                    
                    Spacer()
                    
                    Text(post?.duration ?? "")
                }
                .foregroundColor(Color.gray79)
                .font(.footnote)
                .padding(.top, 10)
                
                Text(post?.description ?? "")
                    .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
        }
    }
}

struct PostCommentReplyPreview_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentReplyPreview(post: MockData.post[0])
            .environment(\.colorScheme, .dark)
    }
}
