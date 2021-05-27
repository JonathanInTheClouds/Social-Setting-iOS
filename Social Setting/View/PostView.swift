//
//  PostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/7/21.
//

import SwiftUI

struct PostView: View {
    
    @State var bookmarked = false
    
    @State var liked = false
    
    @State var reply = false
    
    var body: some View {
        VStack {
            PostViewHeader()
            
            Color.labelTertiary
                .frame(height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea(.all, edges: .horizontal)
            
            HStack(spacing: 29.5) {
                Button(action: {
                    liked.toggle()
                }, label: {
                    HStack {
                        Image(systemName: (liked ? "heart.fill" : "heart"))
                        Text("Like")
                    }
                })
                .foregroundColor(liked ? .accentColor : .labelSecondary)
                
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
                    bookmarked.toggle()
                }, label: {
                    Image(systemName: (bookmarked ? "bookmark.fill" : "bookmark"))
                })
                .foregroundColor(bookmarked ? .accentColor : .labelSecondary)
                
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            
            HStack {
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        Text("420")
                            .bold()
                        Text("likes")
                    })
                Text("·")
                NavigationLink(
                    destination: CommentsView(),
                    label: {
                        Text("16")
                            .bold()
                        Text("comments")
                    })
                Spacer()
            }
            .foregroundColor(Color.labelPrimary)
            .padding(.horizontal, 16)
            
            Text("I recently understood the words of my friend Jacob West about music.")
                .padding(.vertical, 1)
                .padding(.horizontal, 14)
        }
        .padding(.bottom)
        .sheet(isPresented: $reply, content: {
            ReplyView(opened: $reply)
        })
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

struct PostViewHeader: View {
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
                            Text("Joshua Lawrance")
                                .foregroundColor(Color.labelPrimary)
                        })
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.accentColor)
                }
                
                HStack {
                    Text("@joshua_l")
                    Text("·")
                    Text("2h ago")
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
