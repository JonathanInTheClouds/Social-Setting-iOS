//
//  PostContextMenu.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/29/20.
//

import SwiftUI

struct PostContextMenu: View {
    
    @EnvironmentObject private var postViewModel: PostViewModel
    @EnvironmentObject private var feedViewModel: FeedViewModel
    
    var postId: Int
    
    var body: some View {
        VStack {
            Button(action: { }, label:
            {
                HStack {
                    Text("Save")
                    Image(systemName: "checkmark.rectangle.portrait.fill")
                }
            })
            
            Button(action: likeButtonAction, label:
            {
                HStack {
                    Text("\(feedViewModel.postFeed[postId].upVote ? "Unlike": "Like")")
                    Image(systemName: "suit.heart.fill")
                }
            })
        }
    }
    
    private func likeButtonAction() {
        feedViewModel.postFeed[postId].upVote.toggle()
        postViewModel.likePost(post: feedViewModel.postFeed[postId])
        if feedViewModel.postFeed[postId].upVote {
            feedViewModel.postFeed[postId].voteCount += 1
        } else {
            feedViewModel.postFeed[postId].voteCount -= 1
        }
    }
}

struct PostContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        PostContextMenu(postId: 1)
    }
}
