//
//  PostCreateCommentView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/18/21.
//

import SwiftUI
import TextView

struct PostCreateCommentView: View {
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    @ObservedObject var postCommentViewModel: PostCommentViewModel = PostCommentViewModel()
    
    @State var commentText = ""
    
    @State var commentEditing = true
    
    @State var progressValue: Float = 0.0
    
    @Binding var commentList: [CommentResponse]
    
    @Binding var targetPost: PostResponse
    
    init(commentList: Binding<[CommentResponse]>, targetPost: Binding<PostResponse>) {
        // for navigation bar title color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.clear]
        // For navigation bar background color
        UINavigationBar.appearance().backgroundColor = UIColor(Color.navAltColor)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        self._commentList = commentList
        self._targetPost = targetPost
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $commentText, isEditing: $commentEditing,
                         placeholder: "Whats on your mind?", textHorizontalPadding: 16,
                         placeholderHorizontalPadding: 20, font: .systemFont(ofSize: 18))
                    .padding(.top, 20)
                VStack(spacing: 0) {
                    ProgressBar(value: $progressValue)
                        .frame(height: 1)
                    PostCommentReplyPreview(post: commentPopupHelper.commentRequestHelper.post)
                }
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {
                        commentPopupHelper.shouldReply = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color.baseColor)
                    })
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.principal) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        VStack {
                            Text("New Comment")
                                .bold()
                                .foregroundColor(Color.labelColor)
                            Text("mettaworldj")
                                .font(.footnote)
                                .foregroundColor(Color.gray79)
                        }
                    })
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        guard let post = commentPopupHelper.commentRequestHelper.post else { return }
                        startProgressBar()
                        postCommentViewModel.createComment(subSettingName: post.subSettingName, postId: Int(post.postId), text: commentText) { (result) in
                            switch result {
                            case .success(let commentResponse):
                                commentList.append(commentResponse)
                                progressValue = 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    commentPopupHelper.shouldReply = false
                                    targetPost.commentCount += 1
                                }
                            case .failure(_):
                                resetProgressBar()
                            }
                        }
                    }, label: {
                        Text("Post")
                            .foregroundColor(Color.baseColor)
                    })
                    .disabled(commentText.isEmpty)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .modifier(DisableModalDismiss(disabled: !commentText.isEmpty))
        }
        .onDisappear {
            // for navigation bar title color
            UINavigationBar.appearance().titleTextAttributes = nil
            // For navigation bar background color
            UINavigationBar.appearance().backgroundColor = nil
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = nil
            UINavigationBar.appearance().isTranslucent = true
        }
    }
    
    func startProgressBar() {
        for _ in 0...30 {
            self.progressValue += 0.015
        }
    }
    
    func finishProgressBar(competion: @escaping () -> ()) {
        
    }
    
    func resetProgressBar() {
        self.progressValue = 0
    }
}

struct PostCreateCommentView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateCommentView(commentList: .constant([CommentResponse]()), targetPost: .constant(MockData.post[0]))
    }
}
