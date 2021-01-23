//
//  FeedView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    var body: some View {
        NavigationView {
            DynamicBackground(alignment: .leading) {
                ScrollView {
                    LazyVStack {
                        ForEach (feedViewModel.postFeed.indices, id: \.self) { index in
                            PostFeedView(post: $feedViewModel.postFeed[index])
                                .contextMenu(ContextMenu(menuItems: {
                                    PostContextMenu(post: $feedViewModel.postFeed[index])
                                }))
                                .groupBoxStyle(PostGroupBoxStyle(destination: Text("In Side"), post: feedViewModel.postFeed[index]))
                                .actionSheet(isPresented: $feedViewModel.showActionSheet) {
                                    actionSheetView(targetPost: feedViewModel.postFeed[index])
                                }
                            PostSeperator()
                                .onAppear { fetchMoreIfNecessary(current: index) }
                        }
                    }
                    .padding(.top, 15)
                }
            }
            .navigationBarItems(leading: FeedNavigationLogo(), trailing: FeedCreatePostButton())
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                feedViewModel.getFeed()
                print("Fetching Feed...")
            }
        }
    }
    
    fileprivate func fetchMoreIfNecessary(current: Int) {
        let lastIndex = feedViewModel.postFeed.count - 1
        let shouldLoadMore = lastIndex == current
        if shouldLoadMore {
            feedViewModel.getFeed()
        }
    }
    
    
    fileprivate func actionSheetView(targetPost: PostResponse) -> ActionSheet {
        let currentUser = SocialSettingAPI.agent.savedAuthentication?.username == targetPost.username
        if currentUser {
            return ActionSheet(title: Text("Post Options"), message: nil, buttons: [
                .destructive(Text("Delete"), action: {
                    feedViewModel.deletePost()
                }),
                .destructive(Text("Report"), action: {
                    print("\(targetPost.username) has been reported")
                }),
                .cancel()
            ])
        }
        return ActionSheet(title: Text("Post Options"), message: nil, buttons: [
            .destructive(Text("Report"), action: {
                print("\(targetPost.username) has been reported")
            }),
            .cancel()
        ])
    }
    
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

