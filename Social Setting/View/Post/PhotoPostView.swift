//
//  PhotoPostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/27/21.
//

import SwiftUI

struct PhotoPostView: View {
    
    @Binding var post: PostModel
    
    @Binding var reply: Bool
    
    var body: some View {
        
        VStack {
            PostViewHeader(name: post.user.name, username: post.user.username, timeAgo: post.timeAgo)
            
            Color.labelTertiary
                .frame(height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea(.all, edges: .horizontal)
            
            HStack(spacing: 29.5) {
                Button(action: {
                    post.liked.toggle()
                }, label: {
                    HStack {
                        Image(systemName: (post.liked ? "heart.fill" : "heart"))
                        Text("Like")
                    }
                })
                .foregroundColor(post.liked ? .accentColor : .labelSecondary)
                
                Button(action: {
                    reply = true
                }, label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Text("Reply")
                    }
                })
                .foregroundColor(Color.labelSecondary)
                
                Spacer()
                
                Button(action: {
                    post.bookMarked.toggle()
                }, label: {
                    Image(systemName: (post.bookMarked ? "bookmark.fill" : "bookmark"))
                })
                .foregroundColor(post.bookMarked ? .accentColor : .labelSecondary)
                
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            
            HStack {
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        Text("\(post.likes)")
                            .bold()
                        Text("likes")
                    })
                Text("·")
                NavigationLink(
                    destination: CommentsView(viewModel: CommentViewModel(), post: $post),
                    label: {
                        Text("\(post.comments)")
                            .bold()
                        Text("comments")
                    })
                Spacer()
            }
            .foregroundColor(Color.labelPrimary)
            .padding(.horizontal, 16)
            
            HStack {
                Text(post.text)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
                .padding(.vertical, 1)
                .padding(.horizontal, 16)
        }
        
    }
}


struct PhotoPostView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPostView(post: .constant(posts[0]), reply: .constant(false))
    }
}
