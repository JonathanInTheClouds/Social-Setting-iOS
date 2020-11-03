//
//  CreatePostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/26/20.
//

import SwiftUI
import iTextField
import TextView

struct CreatePostView: View {
    
    @StateObject var createPostViewModel: CreatePostViewModel = CreatePostViewModel()
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @State private var selection: Int = 0
    
    @State private var titleText: String = ""
    
    @State private var titleEditing: Bool = false
    
    @State private var bodyText: String = ""
    
    @State private var bodyEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(selection: $selection)
                
                if selection != 2 {
                    BodyView(titleText: $titleText, titleEditing: $titleEditing, bodyText: $bodyText, bodyEditing: $bodyEditing)
                } else {
                    PostPreview(post: previewPostModel())
                }
                
                Spacer()
            }
            .navigationTitle(Text("Create Post"))
            .navigationBarItems(trailing: Button(action: createPost, label: {
                Image(systemName: "paperplane.fill")
            }))
        }
    }
 
    private func createPost() {
        let postRequest = PostRequestModel(postName: titleText, description: bodyText, isProfilePost: true)
        createPostViewModel.createPost(postRequest: postRequest, completion: { createdPost in
            feedViewModel.createPostIsPresented = false
            feedViewModel.postFeed.insert(createdPost, at: 0)
        })
    }
    
    func previewPostModel() -> Binding<PostResponseModel> {
        return Binding<PostResponseModel>(get: {
            PostResponseModel(localId: nil, id: 1, publicUserId: "", postName: titleText, url: nil, description: bodyText, userName: "MettaworldJ", subSettingName: "", duration: "just now", upVote: true, downVote: false, voteCount: 24, commentCount: 12)
        }, set: {_ in
            
        })
    }

}

private struct HeaderView: View {
    @Binding var selection: Int
    
    var body: some View {
        
        Picker(selection: Binding<Int>(
            get: { selection }, set: { tag in
                withAnimation(.easeIn(duration: 0.3)) {
                    selection = tag
                }
            }
        ), label: Text("What type of post?")) {
            Text("Post").tag(0)
            Text("Article").tag(1)
            Text("Preview").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .padding(.top)
    }
}

private struct BodyView: View {
    
    @Binding var titleText: String
    
    @Binding var titleEditing: Bool
    
    @Binding var bodyText: String
    
    @Binding var bodyEditing: Bool
    
    var body: some View {
        PlainTextView("Title", text: $titleText, isEditing: $titleEditing)
            .fontFromUIFont(.preferredFont(forTextStyle: .largeTitle))
            .padding(.horizontal)
            .padding(.vertical)
        TextView(text: $bodyText, isEditing: $bodyEditing, placeholder: "Whats on your mind?", textHorizontalPadding: 16, placeholderHorizontalPadding: 20, font: .systemFont(ofSize: 18))
    }
}

private struct PostPreview: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        TopicPostView(post: $post)
            .padding(.all)
            .background(Color.tertiarySystemBackground)
            .cornerRadius(8)
            .padding(.all)
    }
}


struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreatePostView()
                .environment(\.colorScheme, .light)
                .environmentObject(FeedViewModel())
            
            CreatePostView()
                .environment(\.colorScheme, .dark)
                .environmentObject(FeedViewModel())
        }
    }
}
