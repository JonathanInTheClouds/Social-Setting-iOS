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
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    @ObservedObject var postCreateViewModel = PostCreateViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView()
                    .environmentObject(postCreateViewModel)
                
                if postCreateViewModel.selection != 2 {
                    BodyView(titleText: $postCreateViewModel.titleText,
                             titleEditing: $postCreateViewModel.titleEditing,
                             bodyText: $postCreateViewModel.bodyText,
                             bodyEditing: $postCreateViewModel.bodyEditing)
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
        let postRequest = PostRequest(postName: postCreateViewModel.titleText, url: nil, description: postCreateViewModel.bodyText)
        feedViewModel.createPost(post: postRequest)
    }
    
    func previewPostModel() -> Binding<PostResponse> {
        print(Int.max)
        return Binding<PostResponse>(get: {
            PostResponse(subSettingId: 1,
                         postId: 1,
                         postName: postCreateViewModel.titleText,
                         description: postCreateViewModel.bodyText,
                         url: nil,
                         userPublicId: "",
                         username: SocialSettingAPI.agent.savedAuthentication?.username ?? "",
                         subSettingName: "", voteCount: 24, commentCount: 12, duration: "Just now",
                         upVote: true, downVote: false)
        }, set: {_ in })
    }
}

private struct HeaderView: View {
    
    @EnvironmentObject var postCreateViewModel: PostCreateViewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                HStack {
                    Text(" TO: ")
                    NavigationLink(destination: PostCreateSubscriptionListView(subSettingName: $postCreateViewModel.subSettingName)) {
                        HStack {
                            Text(postCreateViewModel.subSettingName ?? "")
                                .foregroundColor(Color.labelColor)
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.labelColor)
                        }
                    }
                    .padding(.horizontal, 15)
                    .frame(height: 30)
                    .background(Color.itemColor)
                    .cornerRadius(6)
                }
                
                Spacer()
            })
            .padding(.vertical, 5)
            
            Picker(selection: Binding<Int>(
                get: { postCreateViewModel.selection }, set: { tag in
                    withAnimation(.easeIn(duration: 0.3)) {
                        postCreateViewModel.selection = tag
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
                
                HStack {
                    ProfileImage(buttonSize: 50, imageSize: 20, destination: Text("Hello World"))
                    VStack {
                        HStack {
                            Text(post.username)
                                .foregroundColor(.gray99)
                                .font(.callout)
                            Spacer()
                        }
                        HStack {
                            Text(post.duration)
                                .foregroundColor(.gray79)
                                .font(.caption)
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print(post.postName)
                    }, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color.gray79)
                        }
                        .frame(width: 50, height: 50, alignment: .center)
                    })
                }
                
                PostBodyView(post: post)
                    .padding(.bottom)
                NavigationLink(
                    destination: PostCommentView(post: $post),
                    isActive: .constant(false),
                    label: {})
                Color.gray39
                    .frame(height: 1, alignment: .center)
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
            PostCreateView()
                .environment(\.colorScheme, .light)
                .environmentObject(FeedViewModel())
            
            PostCreateView()
                .environment(\.colorScheme, .dark)
                .environmentObject(FeedViewModel())
        }
    }
}
