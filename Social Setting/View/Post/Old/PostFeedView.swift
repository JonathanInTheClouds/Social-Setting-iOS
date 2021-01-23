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
                    PostBodyView2(post: post)
                        .padding(.bottom)
                    NavigationLink(
                        destination: PostCommentView(post: $post),
                        isActive: $shouldPush,
                        label: {})
                    Color.gray39
                        .frame(height: 1, alignment: .center)
                    PostHButtonView1(post: $post)
                }
            }
            .onTapGesture {
                shouldPush = true
            }
            if post.deleted ?? false {
                PostDeleteView()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct PostFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedView(post: .constant(MockData.post[0]))
    }
}
