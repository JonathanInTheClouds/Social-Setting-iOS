//
//  PostHButtonView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI


struct PostHButtonView1: View {
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    @Binding var post: PostResponse
    
    private let likeButtonColor = Color.baseColor
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                post.upVote.toggle()
                post.voteCount += post.upVote ? 1 : -1
                postViewModel.likePost(post: post)
                Vibration.soft.vibrate()
            }, label: {
                HStack {
                    Image(systemName: "suit.heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(post.upVote ? .baseColor : .gray79)
                        .padding(.trailing, 5)
                    
                    Text("\(post.voteCount)")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                commentPopupHelper.commentRequestHelper.post = post
                commentPopupHelper.shouldReply = true
            }, label: {
                HStack {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color.gray79)
                        .padding(.trailing, 5)
                    
                    Text("\(post.commentCount)")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "arrowshape.bounce.right.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color.gray79)
                        .padding(.trailing, 5)
                    
                    
                    Text("4")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
    
}

struct PostHButtonView_Previews2: PreviewProvider {
    static var previews: some View {
        PostHButtonView1(post: .constant(MockData.post[0]))
    }
}
