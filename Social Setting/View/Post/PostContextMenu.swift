//
//  PostContextMenu.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct PostContextMenu: View {
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    @Binding var post: PostResponse
    
    var body: some View {
        VStack {
            Button(action: {
                post.upVote.toggle()
                post.voteCount += post.upVote ? 1 : -1
                postViewModel.likePost(post: post)
                Vibration.soft.vibrate()
            }, label: {
                HStack {
                    Text(post.upVote ? "Unlike" : "Like")
                    Image(systemName: "suit.heart.fill")
                }
            })
            
            Button(action: {}, label: {
                HStack {
                    Text("Save")
                    Image(systemName: "checkmark.rectangle.portrait.fill")
                }
            })
        }
    }
}

struct PostContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        PostContextMenu(post: .constant(MockData.post[0]))
    }
}
