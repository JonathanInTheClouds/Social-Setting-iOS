//
//  PostFeedView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct PostFeedView: View {
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    
    @Binding var post: PostResponse
    
    @State var shouldPush = false
    
    var body: some View {
        ZStack {
            GroupBox {
                VStack(alignment: .leading) {
                    PostBodyView(post: post)
                        .padding(.bottom)
                    NavigationLink(
                        destination: PostCommentView(post: $post),
                        isActive: $shouldPush,
                        label: {})
                    Color.gray39
                        .frame(height: 1, alignment: .center)
                    PostHButtonView(post: $post)
                }
            }
            .onTapGesture {
                shouldPush = true
            }
            
            if post.deleted ?? false {
                PostDeleteView()
            }
        }
        .sheet(isPresented: $commentPopupHelper.shouldReply) {
            PostCreateCommentView(commentList: .constant([CommentResponse]()))
                .environmentObject(commentPopupHelper)
        }
    }
}

struct PostFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedView(post: .constant(MockData.post[0]))
    }
}
