//
//  PostCommentView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/4/20.
//

import SwiftUI

struct PostCommentView: View {
    
    @Binding var comment: CommentResponseModel
    
    @State var showReplies = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            CommentHeadView(comment: $comment)
            CommentBodyView(comment: $comment)
            CommentFootView(showReplies: $showReplies)
            if showReplies {
                ReplyView(showReplies: $showReplies)
                SeeMoreView()
            }
        }
    }
}

struct PostCommentView_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentView(comment: .constant(CommentResponseModel(id: 0, postId: 0, text: "", username: "", duration: "")))
            .padding(.horizontal, 16)
    }
}

private struct CommentHeadView: View {
    
    @Binding var comment: CommentResponseModel
    
    var body: some View {
        HStack(spacing: 10) {
            ProfileImage(buttonSize: 32, imageSize: 15)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("\(comment.username)")
                    .font(.callout)
                    .foregroundColor(Color.gray99)
            })
            Spacer()
            Text(comment.duration)
                .font(.footnote)
                .foregroundColor(Color.gray79)
                .offset(x: 15)
            Button(action: {
                print("Clicked")
            }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color.gray79)
                }
                .frame(width: 50, height: 50, alignment: .center)
            })
        }
    }
}

private struct CommentBodyView: View {
    
    @Binding var comment: CommentResponseModel
    
    var body: some View {
        Text("\(comment.text)")
            .font(.body)
            .foregroundColor(.gray99)
            .padding(.bottom, 10)
    }
}

private struct CommentFootView: View {
    
    @Binding var showReplies: Bool
    
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Text("4 likes")
                    .font(.callout)
                    .foregroundColor(Color.gray79)
            })
            .padding(.trailing)
            
            Button(action: {
                withAnimation {
                    showReplies.toggle()
                }
            }, label: {
                Text("3 replies")
                    .font(.callout)
                    .foregroundColor(Color.gray79)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Text("Reply")
                    .font(.body)
                    .foregroundColor(Color.baseColor)
                    .fontWeight(.medium)
            })
            .padding(.trailing)
            
            Button(action: {}, label: {
                Text("Like")
                    .font(.body)
                    .foregroundColor(Color.baseColor)
                    .fontWeight(.medium)
            })
        }
        .padding(.bottom, showReplies ? 5 : 0)
    }
}

private struct CommentReplyView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            ProfileImage(buttonSize: 32, imageSize: 15)
            Text("Roy Barber  ")
                .foregroundColor(Color.gray99)
                .fontWeight(.medium)
            +
            Text("If you don't have any knowledge about the topic, admit it openly that you don't know.")
                .foregroundColor(Color.gray79)
                .fontWeight(.medium)
            Spacer()
        }
        .padding()
        .background(Color.gray19)
        .cornerRadius(12)
        .padding(.vertical, 6)
        
    }
}

struct ReplyView: View {
    
    @Binding var showReplies: Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Button(action: {
                withAnimation {
                    showReplies.toggle()
                }
            }, label: {
                Image(systemName: "arrow.up")
                    .foregroundColor(.gray79)
            })
            .padding(.bottom, 26)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(1...2, id: \.self) { n in
                        CommentReplyView()
                    }
                }
            })
        }
        .padding(.bottom, 8)
    }
}

struct SeeMoreView: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Image(systemName: "arrow.up")
                    .foregroundColor(.clear)
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                    Text("See all 5 replies")
                }
            })
        }.foregroundColor(Color.gray79)
    }
}
