//
//  OpenPostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/29/20.
//

import SwiftUI

struct PostDetailView: View {
        
    @EnvironmentObject var postDetailViewModel: PostDetailViewModel
    
    @State var isLoaded = false
    
    var body: some View {
        ZStack {
            Color.tertiarySystemBackground
                .ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    VStack(alignment: .leading) {
                        PostHeadView(username: postDetailViewModel.post.username, timeAgo: postDetailViewModel.post.duration)
                            .padding(.horizontal, 16)
                        TopicMainBody(post: $postDetailViewModel.post)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 16)
                        PostButtonHStack(post: $postDetailViewModel.post)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        Separator() 
                            .frame(height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        ForEach(postDetailViewModel.comments.indices, id: \.self) { id in
                            PostCommentView(comment: $postDetailViewModel.comments[id])
                                .padding(.horizontal, 16)
                                .padding(.bottom)
                            Separator()
                                .frame(height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .padding(.top, 25)
                }
            }
            .navigationTitle("1 comments")
            .onAppear {
                if !isLoaded {
                    self.postDetailViewModel.fetchFeed()
                }
                self.isLoaded = true
            }
        }
    }
}

struct OpenPostView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
            .environmentObject(PostDetailViewModel(post: PostResponseModel(id: 1, postName: "Openly admit that you don't know something", url: nil, description: "If you don't have any knowledge about the topic, admit it openly that you don't know.", username: "MettaworldJ", subSettingName: "", duration: "just not", upVote: true, downVote: false, voteCount: 61, commentCount: 147)))
    }
}
