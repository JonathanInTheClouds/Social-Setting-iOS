//
//  PostCreateView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI
import TextView

struct PostCreateView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @ObservedObject var feedViewModel: FeedViewModel
    
    @EnvironmentObject var postViewModel: PostViewModel
    
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
            .navigationTitle(Text("Send"))
            .navigationBarItems(trailing: Button(action: createPost, label: {
                Image(systemName: "paperplane.fill")
            }))
        }
    }
    
    private func createPost() {
        let postRequest = PostRequest(postName: titleText, url: nil, description: bodyText)
        feedViewModel.createPost(post: postRequest)
    }
    
    func previewPostModel() -> Binding<PostResponse> {
        return Binding<PostResponse>(get: {
            PostResponse(subSettingId: 1, postId: 1, postName: titleText, description: bodyText, url: nil, userPublicId: "", username: SocialSettingAPI.agent.savedAuthentication?.username ?? "", subSettingName: "", voteCount: 24, commentCount: 12, duration: "Just now", upVote: true, downVote: false)
        }, set: {_ in })
    }
}

private struct HeaderView: View {
    @Binding var selection: Int
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                
                HStack {
                    
                    Text(" TO: ")
                    
                    AlternativeButtonView({
                        print("Hello World")
                    }, {
                        HStack {
                            Text("CS Students")
                                .foregroundColor(Color.labelColor)
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.labelColor)
                        }
                    })
                    .frame(height: 30)
                    .background(Color.itemColor)
                    .cornerRadius(6)
                }
                
                Spacer()
            })
            .padding(.vertical, 5)
            
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
        }
        .padding(.horizontal)
//        .padding(.top)
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
    
    @Binding var post: PostResponse
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                PostHeadView(destination: Text(""), post: post)
                
                PostBodyView(post: post)
                    .padding(.bottom)
                
                PostHButtonView(post: $post)
            }
        }
        .background(Color.tertiarySystemBackground)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
        .padding()
        
    }
}


struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCreateView(feedViewModel: FeedViewModel())
                .environment(\.colorScheme, .light)
                .environmentObject(FeedViewModel())
            
            PostCreateView(feedViewModel: FeedViewModel())
                .environment(\.colorScheme, .dark)
                .environmentObject(FeedViewModel())
        }
    }
}
