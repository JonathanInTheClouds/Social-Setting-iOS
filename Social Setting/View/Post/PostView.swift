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
        if post.postType == .photo {
            PhotoPostView(post: $post, reply: $reply)
                .padding(.bottom)
                .sheet(isPresented: $reply, content: {
                    ReplyView(opened: $reply, name: post.user.name, username: post.user.username, timeAgo: post.timeAgo, text: post.text, action: {
                        post.comments += 1
                    })
                })
        } else if post.postType == .regular {
            RegularPostView(post: $post, reply: $reply)
                .sheet(isPresented: $reply, content: {
                    ReplyView(opened: $reply, name: post.user.name, username: post.user.username, timeAgo: post.timeAgo, text: post.text, action: {
                        post.comments += 1
                    })
                })
        } else if post.postType == .share {
            SharePostView(post: $post, reply: $reply)
                .sheet(isPresented: $reply, content: {
                    ReplyView(opened: $reply, name: post.user.name, username: post.user.username, timeAgo: post.timeAgo, text: post.text, action: {
                        post.comments += 1
                    })
                })
        }
    }
    
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: posts[0])
    }
}

struct PostViewHeader: View {
    
    let name: String
    
    let username: String
    
    let timeAgo: String
    
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
                            Text(name)
                                .foregroundColor(Color.labelPrimary)
                        })
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.accentColor)
                }
                
                HStack {
                    Text("@\(username)")
                    Text("·")
                    Text(timeAgo)
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





