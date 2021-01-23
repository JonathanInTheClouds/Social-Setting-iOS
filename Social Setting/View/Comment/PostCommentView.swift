//
//  PostCommentView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/8/21.
//

import SwiftUI
import ASCollectionView

struct PostCommentView: View {
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    @Binding var post: PostResponse
    
    @ObservedObject private var postCommentViewModel = PostCommentViewModel()
    
    @State private var commentList = [CommentResponse]()
    
    @State private var shouldReply = false
    
    @State private var page = 0
    
    var body: some View {
        DynamicBackground {
            ScrollView {
                LazyVStack {
                    PostFeedView(post: $post)
                        .groupBoxStyle(PostGroupBoxStyle(destination: Text(""), post: post))
                    Group {
                        CommentHeader()
                        ForEach(commentList.indices, id: \.self) { index in
                            CommentView(commentList: $commentList, post: $post, index: index)
                            Color.gray39
                                .frame(height: 1)
                                .onAppear {
                                    fetchMoreIfNecessary(current: index)
                                }
                        }
                    }
                    .opacity(!commentList.isEmpty ? 1 : 0)
                    .padding(.vertical, 5)
                    .padding(.top, 1)
                }
            }
        }
        .onAppear(perform: {
            postCommentViewModel.getComments(subSettingName: post.subSettingName, postId: post.postId, page: page, completion: handleData)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Spacer()
                    Button(action: {
                        Vibration.light.vibrate()
                    }, label: {
                        Image("large-logo")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                    })
                }
            }
        }
        .sheet(isPresented: $commentPopupHelper.shouldReply) {
            PostCreateCommentViewAlt(isOpen: $commentPopupHelper.shouldReply, commentList: $commentList, targetPost: $post)
        }
//        .sheet(isPresented: $commentPopupHelper.shouldReply, content: {
//            PostCreateCommentView(commentList: $commentList, targetPost: $post)
//                .environmentObject(commentPopupHelper)
//        })
    }
    
    fileprivate func fetchMoreIfNecessary(current: Int) {
        let lastIndex = commentList.count - 1
        let shouldLoadMore = (lastIndex == current)
        if shouldLoadMore {
            postCommentViewModel.getComments(subSettingName: post.subSettingName, postId: post.postId, page: page, completion: handleData)
        }
    }
    
    fileprivate func handleData(_ data: Result<CommentFeedResponse, Error>) {
        switch data {
        case .success(let result):
            self.commentList.append(contentsOf: result.comments)
            if !result.comments.isEmpty { page += 1 }
            guard let post = result.post else { return }
            self.post.commentCount = post.commentCount
            self.post.voteCount = post.voteCount
            self.post.upVote = post.upVote
        case .failure(_):
            print("Error")
        }
    }
    
}

struct PostCommentView_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentView(post: .constant(MockData.post[0]))
    }
}

private struct CommentHeader: View {
    var body: some View {
        ZStack {
            Color.gray19
                .frame(height: 56)
            VStack {
                Spacer()
                HStack {
                    Text("COMMENTS")
                        .font(.caption)
                        .foregroundColor(Color.gray79)
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}


private struct CommentView: View {
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    @Binding private(set) var commentList: [CommentResponse]
    
    @Binding private(set) var post: PostResponse
    
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ProfileImage(buttonSize: 32, imageSize: 14, destination: Text(""))
                Text(commentList[index].username)
                
                Spacer()
                
                Text(post.duration)
                    .foregroundColor(.gray79)
                    .font(.footnote)
                
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.gray79)
                    }
                    .frame(width: 50, height: 25, alignment: .center)
                })
            }
            Text(commentList[index].text)
                .foregroundColor(Color.gray99)
            HStack {
                if let likes = commentList[index].likes, likes != 0 {
                    Text("\(likes) likes")
                        .foregroundColor(.gray79)
                        .font(.footnote)
                } else {
                    Text("- likes")
                        .foregroundColor(.gray79)
                        .font(.footnote)
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button(action: {
                        commentPopupHelper.commentRequestHelper.post = post
                        commentPopupHelper.shouldReply = true
                    }, label: {
                        Text("Reply")
                            .foregroundColor(.baseColor)
                            .font(.footnote)
                    })
                    
                    Button(action: {
                        Vibration.soft.vibrate()
                        withAnimation {
                            if let _ =  commentList[index].likes {
                                commentList[index].likes! += 1
                            } else {
                                commentList[index].likes = 1
                            }
                        }
                    }, label: {
                        Text("Like")
                            .foregroundColor(.baseColor)
                            .font(.footnote)
                    })
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
