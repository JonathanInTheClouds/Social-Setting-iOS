//
//  Feed.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/14/20.
//

import SwiftUI
import SwiftKeychainWrapper

struct FeedView: View {
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.tertiarySystemBackground
                    .edgesIgnoringSafeArea(.all)
                MainFeedView()
                .navigationBarItems(leading: LeftHeadingSection(), trailing: RightHeadingSection())
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    
    
    
    
}



private struct LeftHeadingSection: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.easeOut(duration: 0.3)) {
                    KeychainWrapper.standard.remove(forKey: "auth_token")
                    authViewModel.validationConfirmed = false
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


private struct RightHeadingSection: View {
    
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
                CreatePostView(feedViewModel: feedViewModel)
            }
        }
    }
}


private struct MainFeedView: View {
    
    @EnvironmentObject private var feedViewModel: FeedViewModel
    
    private var actionSheet: ActionSheet {
        ActionSheet(title: Text("Post Options"), message: Text("Choose Option"), buttons: [
            .default(Text("Save")),
            .default(Text("Delete")),
            .cancel()
        ])
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(feedViewModel.postFeed.indices, id: \.self) { id in
                    PostContentView(post: $feedViewModel.postFeed[id])
                        .environmentObject(feedViewModel)
                        .onAppear {fetchMoreIfNecessary(current: id)}
                        .contextMenu {
                            PostContextMenu(postId: id)
                                .environmentObject(feedViewModel)
                        }
                        .actionSheet(isPresented: $feedViewModel.showingActionSheet, content: {
                            self.actionSheetView(postId: id)
                        })
                    Separator()
                }
                .opacity(feedViewModel.postFeed.isEmpty ? 0 : 1)
            }
            .padding(.top, 5)
        }.onAppear(perform: feedViewModel.fetchFeed)
    }
    
    fileprivate func fetchMoreIfNecessary(current: Int) {
        let lastIndex = feedViewModel.postFeed.count - 1
        let shouldLoadMore = lastIndex == current
        if shouldLoadMore {
            feedViewModel.fetchFeed()
        }
    }
    
    
    fileprivate func actionSheetView(postId: Int) -> ActionSheet {
        return ActionSheet(title: Text("Post Options"), message: nil, buttons: [
            .destructive(Text("Report"), action: {
                print("\(feedViewModel.postFeed[postId].userName) has been reported")
            }),
            .cancel()
        ])
    }
    
}


struct Feed_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FeedView()
                .environment(\.colorScheme, .light)
            
            FeedView()
                .environment(\.colorScheme, .dark)
        }
    }
}
