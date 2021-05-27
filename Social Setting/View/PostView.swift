//
//  PostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/7/21.
//

import SwiftUI
import LoremSwiftum

struct PostView: View {
    
    @State var post: PostModel
    
    @State var reply = false
    
    var body: some View {
        VStack {
            PostViewHeader(post: post)
            
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
                    destination: CommentsView(post: $post),
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
                Text(post.details)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
                .padding(.vertical, 1)
                .padding(.horizontal, 16)
        }
        .padding(.bottom)
        .sheet(isPresented: $reply, content: {
            ReplyView(opened: $reply)
        })
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: posts[0])
    }
}

struct PostViewHeader: View {
    
    var post: PostModel
    
    var body: some View {
        HStack {
            NavigationLink(
                destination: ProfileView(),
                label: {
                    Image("User")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                })
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .center) {
                    NavigationLink(
                        destination: ProfileView(),
                        label: {
                            Text(post.name)
                                .foregroundColor(Color.labelPrimary)
                        })
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.accentColor)
                }
                
                HStack {
                    Text("@\(post.username)")
                    Text("·")
                    Text("\(post.timeAgo)")
                }
                .foregroundColor(Color.labelSecondary)
            }
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(Color.labelSecondary)
                    .padding(.all, 5)
            })
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}
