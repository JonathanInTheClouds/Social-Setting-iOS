//
//  NormalPostView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI

struct NormalPostView: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        VStack(alignment: .leading) {
            PostHeadView(username: post.username, timeAgo: post.duration)
            MainBody(bodyText: post.description)
                .foregroundColor(Color.gray99)
                .padding(.bottom, 15)
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Color.gray39
                .frame(height: 1, alignment: .center)
            ButtonHStack(post: $post)
        }
    }
}

struct PostHeadView: View {
    
    @EnvironmentObject private var feedViewModel: FeedViewModel
    
    var username: String
    
    var timeAgo: String
    
    
    var body: some View {
        HStack {
            ProfileImage(buttonSize: 50, imageSize: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text(username)
                        .foregroundColor(Color.gray99)
                        .font(.callout)
                })
                Text(timeAgo)
                    .foregroundColor(Color.gray79)
                    .font(.caption)
            }
            
            Spacer()
            
            Button(action: {
                feedViewModel.showingActionSheet = true
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

private struct MainBody: View {
    
    var bodyText: String
    
    var photoURL: String?
    
    
    var body: some View {
        VStack {
            Text(bodyText)
                .font(setFont(text: bodyText))
            if photoURL == nil { // Temp
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("placeholder-photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180, alignment: .center)
                        .cornerRadius(6)
                        .clipped()
                })
            }
        }
    }
    
    func setFont(text: String) -> Font? {
        if text.count <= 50 {
            return .title
        }
        
        if text.count <= 80 {
            return .title2
        }
        
        return .title3
    }
}

struct ButtonHStack: View {
    
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

struct NormalPostView_Previews: PreviewProvider {
    
    static var previews: some View {
        NormalPostView(post: .constant(PostResponseModel(id: 1, postName: "Openly admit that you don't know something", url: nil,
                                                         description: "If you don't have any knowledge about the topic, admit it openly that you don't know.", username: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false, voteCount: 61, commentCount: 147)))
    }
}
