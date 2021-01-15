//
//  PostCommentView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/8/21.
//

import SwiftUI
import ASCollectionView

struct PostCommentView: View {
    
    @ObservedObject var postCommentViewModel = PostCommentViewModel()
    
    @State var commentList = [CommentResponse]()
    
    @Binding var post: PostResponse
    
    var body: some View {
        DynamicBackground {
            ScrollView {
                LazyVStack {
                    PostFeedView(post: $post)
                        .groupBoxStyle(PostGroupBoxStyle(destination: Text(""), post: post))
                    CommentHeader()
                    ForEach(commentList.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                ProfileImage(buttonSize: 32, imageSize: 14, destination: Text(""))
                                Text(commentList[index].username)
                                
                                Spacer()
                                
                                Text(post.duration)
                                    .foregroundColor(.gray79)
                                    .font(.footnote)
                                
                                Button(action: {
                                }, label: {
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
                        }
                        .padding(.horizontal, 16)
                        Color.gray39
                            .frame(height: 1)
                    }
                    .padding(.vertical, 5)
                    .padding(.top, 1)
                }
            }
        }
        .onAppear(perform: {
            postCommentViewModel.getComments(subSettingName: post.subSettingName, postId: post.postId) { (comments)  in 
                self.commentList.append(contentsOf: comments)
            }
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
