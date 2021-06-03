//
//  RegularPostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/27/21.
//

import SwiftUI

struct RegularPostView: View {
    
    @Binding var post: PostModel
    
    @Binding var reply: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            PostViewHeader(name: post.user.name, username: post.user.username, timeAgo: post.timeAgo)
            
            Text(post.text)
                .font(textSizeCalculator())
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
            .padding(.top, 16)
            
            HStack(spacing: 29.5) {
                Button(action: {
                    post.liked.toggle()
                    post.likes += (post.liked ? 1 : -1)
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
            .padding(.top, 16)
            .padding(.horizontal, 16)
            
        }
    }
    
    func textSizeCalculator() -> Font {
        if 1...90 ~= post.text.count {
            return .title
        } else if 91...150 ~= post.text.count {
            return .title2
        } else {
            return .title3
        }
    }
}

struct RegularPostView_Previews: PreviewProvider {
    static var previews: some View {
        RegularPostView(post: .constant(posts[2]), reply: .constant(false))
    }
}
