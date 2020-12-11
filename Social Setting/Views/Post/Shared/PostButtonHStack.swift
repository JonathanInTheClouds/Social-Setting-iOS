//
//  PostButtonHStack.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/10/20.
//

import SwiftUI

struct PostButtonHStack: View {
    
    @EnvironmentObject private var postViewModel: PostViewModel
    @Binding var post: PostResponseModel
    var spacing: CGFloat = 20
    
    
    private let likeButtonColor = Color.baseColor
    private let shareButtonColor = Color(.sRGB, red: 69/255, green: 142/255, blue: 255/255, opacity: 1)
    
    
    var body: some View {
        HStack(spacing: spacing) {
            Button(action: likeButtonAction, label: {
                HStack {
                    Image(systemName: "suit.heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(post.upVote ? likeButtonColor : .gray79)
                        .padding(.trailing, 5)
                    
                    Text("\(post.voteCount)")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
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
            
            Button(action: {
                shareButtonAction()
            }, label: {
                HStack {
                    Image(systemName: "arrowshape.bounce.right.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(Color.gray79)
                        .padding(.trailing, 5)
                        
                    
                    Text("1")
                        .foregroundColor(Color.gray79)
                }
            })
            .frame(height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        .padding(.top, 5)
    }
    
    private func likeButtonAction() {
        UIDevice.vibrate()
        post.upVote.toggle()
        postViewModel.likePost(post: post)
        if post.upVote {
            post.voteCount += 1
        } else {
            post.voteCount -= 1
        }
    }
    
    private func shareButtonAction() {
        
    }
}

struct PostButtonHStack_Previews: PreviewProvider {
    static var previews: some View {
        PostButtonHStack(post: .constant(PostResponseModel(id: 1,
                                                           postName: "Openly admit that you don't know something", url: nil,
                                                           description: "If you don't have any knowledge about the topic, admit it openly that you don't know.",
                                                           username: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false,
                                                           voteCount: 61, commentCount: 147)))
    }
}
