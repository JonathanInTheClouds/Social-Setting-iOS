//
//  PostBodyView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/23/21.
//

import SwiftUI

struct PostButtonsView: View {
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    @Binding var post: PostResponse
    
    @EnvironmentObject var postViewModel: PostViewModel
    
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
            }).buttonStyle(PlainButtonStyle())
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                Vibration.light.vibrate()
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
            }).buttonStyle(PlainButtonStyle())
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .sheet(isPresented: $commentPopupHelper.shouldReply) {
                if let post = commentPopupHelper.commentRequestHelper.post {
                    PostCreateCommentView(commentList: .constant([CommentResponse]()), targetPost: .constant(post))
                        .environmentObject(commentPopupHelper)
                }
            }
            
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
            .buttonStyle(PlainButtonStyle())
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            Button(action: {
                Vibration.soft.vibrate()
            }, label: {
                HStack {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color.gray79)
                        .padding(.trailing, 5)
                }
            })
            .buttonStyle(PlainButtonStyle())
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct PostButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PostButtonsView(post: .constant(MockData.post[0]))
    }
}
