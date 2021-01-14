//
//  FeedViewAlt.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/6/21.
//

import SwiftUI
import ASCollectionView

struct FeedViewAlt: View {
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    var body: some View {
        NavigationView {
            DynamicBackground {
                ASCollectionView(data: feedViewModel.postFeed.indices, dataID: \.self) { (item, _) in
                    PostFeedView(post: $feedViewModel.postFeed[item])
                        .contextMenu(ContextMenu(menuItems: {
                            PostContextMenu(post: $feedViewModel.postFeed[item])
                        }))
                        .groupBoxStyle(PostGroupBoxStyle(destination: Text("In Side"), post: feedViewModel.postFeed[item]))
                        .onAppear { fetchMoreIfNecessary(current: item) }
                        .actionSheet(isPresented: $feedViewModel.showActionSheet) {
                            actionSheetView(index: item)
                        }
                    
                    PostSeperator()
                }
                .alwaysBounceVertical()
                .onPullToRefresh({ (done) in
                    print("Refreshed")
                    done()
                })
                .onAppear {
                    feedViewModel.getFeed()
                    print("Fetching Feed...")
                }
                
            }
            .navigationBarItems(leading: LeftHeadingSection(), trailing: RightHeadingSection())
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    fileprivate func fetchMoreIfNecessary(current: Int) {
        let lastIndex = feedViewModel.postFeed.count - 1
        let shouldLoadMore = lastIndex == current
        if shouldLoadMore {
            feedViewModel.getFeed()
        }
    }
    
    
    fileprivate func actionSheetView(index: Int) -> ActionSheet {
        let targetPost = feedViewModel.postFeed[index]
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

struct FeedViewAlt_Previews: PreviewProvider {
    static var previews: some View {
        FeedViewAlt()
    }
}

struct LeftHeadingSection: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.easeOut(duration: 0.3)) {
                    authViewModel.signOut()
                }
            } label: {
                Image("large-logo")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                Text("Social Setting")
                    .foregroundColor(Color.gray99)
            }
        }
    }
}


struct RightHeadingSection: View {
    
    @EnvironmentObject private var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack {
            Button {
                feedViewModel.createPostIsPresented = true
            } label: {
                Image(systemName: "rectangle.fill.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 23, height: 23, alignment: .center)
            }
            .sheet(isPresented: $feedViewModel.createPostIsPresented) {
                PostCreateView()
            }
        }
    }
}
