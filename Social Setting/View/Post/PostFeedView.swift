//
//  PostFeedView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct PostFeedView: View {
    
    @Binding var post: PostResponse
    
    @State var shouldPush = false
    
    init(post: Binding<PostResponse>) {
        self._post = post
    }
    
    var body: some View {
        ZStack {
            GroupBox {
                VStack(alignment: .leading) {
                    PostBodyView(post: post)
                        .padding(.bottom)
                    NavigationLink(
                        destination: PostCommentView(),
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
    }
}

struct PostFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostFeedView(post: .constant(MockData.post[0]))
    }
}
