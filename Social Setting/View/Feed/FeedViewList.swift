//
//  FeedViewList.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/22/21.
//

import SwiftUI
import SwiftUIListSeparator

struct FeedViewList: View {
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    @EnvironmentObject var postViewModel: PostViewModel
    
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.flatDarkBackground)
        UITableView.appearance().backgroundColor = UIColor(Color.flatDarkBackground)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(feedViewModel.postFeed.indices, id: \.self) { item in
                    PostView(post: $feedViewModel.postFeed[item])
                        .onAppear {fetchMoreIfNecessary(current: item)}
                        .listRowBackground(Color.flatDarkBackground)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .padding(.top, item == 0 ? 10 : 0)
                        .buttonStyle(PlainButtonStyle())
                }
            }
            .listSeparatorStyle(.none)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    FeedNavigationLogo()
                }
                   
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    FeedCreatePostButton()
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .listSeparatorStyle(.none)
            .onAppear {
                feedViewModel.getFeed()
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

struct FeedViewList_Previews: PreviewProvider {
    static var previews: some View {
        FeedViewList()
    }
}
