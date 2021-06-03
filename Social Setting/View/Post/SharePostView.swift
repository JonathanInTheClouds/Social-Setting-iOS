//
//  SharePostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/27/21.
//

import SwiftUI

struct SharePostView: View {
    
    @Binding var post: PostModel
    
    @Binding var reply: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            PostViewHeader(name: post.user.name, username: post.user.username, timeAgo: post.timeAgo)
            
            Text(post.text)
                .font(textSizeCalculator())
                .padding(.horizontal, 16)
            
            
            ZStack {
                Color.labelQuarternary
                VStack {
                    Spacer()
                    ZStack(alignment: .leading) {
                        Color.offWhite
                            .frame(height: 66, alignment: .center)
                        HStack(spacing: 12) {
                            NavigationLink(
                                destination: ProfileView(),
                                label: {
                                    Image("User")
                                        .resizable()
                                        .frame(width: 40, height: 40, alignment: .center)
                                })
                            VStack(alignment: .leading) {
                                HStack(alignment: .lastTextBaseline) {
                                    Text("Margo Craig")
                                        .foregroundColor(Color.labelPrimary)
                                    Text("5h ago")
                                        .foregroundColor(Color.labelSecondary)
                                        .font(.caption)
                                }
                                Text("I just won a million in the lottery! I'm so proud of him!")
                                    .frame(height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.labelSecondary)
                                    .font(.callout)
                                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                            }
                        }
                        .padding(13)
                    }
                }
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 16)
            
            HStack {
                NavigationLink(
                    destination: Text("Destination"),
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


struct SharePostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SharePostView(post: .constant(posts[0]), reply: .constant(false))
                .preferredColorScheme(.light)
            
            SharePostView(post: .constant(posts[0]), reply: .constant(false))
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
