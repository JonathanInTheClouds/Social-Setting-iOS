//
//  PostView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/23/21.
//

import SwiftUI

struct PostView: View {
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    @Binding var post: PostResponse
    
    @State var showProfile = false
    
    @State var showComment = false
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 0) {
            // Profile Link
            NavigationLink(destination: Text("Profile"), isActive: $showProfile) {
                EmptyView()
            }
            .frame(width: 0, height:0)
            .opacity(0)
            .buttonStyle(PlainButtonStyle())
            
            // Post Comments Link
            NavigationLink(destination: PostCommentView(post: $post), isActive: $showComment) {
                EmptyView()
            }
            .frame(width: 0, height:0)
            .opacity(0)
            .buttonStyle(PlainButtonStyle())
            
            // Post Content
            ZStack(alignment: .leading) {
                Color.flatDarkCardBackground
                VStack(alignment: .leading) {
                    PostHeaderView(showProfile: $showProfile, post: $post)
                    
                    PostBodyView(showProfile: $showProfile, post: $post)
                    
                    PostButtonsView(post: $post)
                    .padding(.top, 10)
                }
                .padding(15)
                .contextMenu {
                    PostContextMenu(post: $post)
                }
            }
            
            // Seperator
            Color.flatDarkBackground
                .frame(height: 10)
        }
        .onTapGesture {
            showComment = true
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: .constant(MockData.post[0]))
    }
}
