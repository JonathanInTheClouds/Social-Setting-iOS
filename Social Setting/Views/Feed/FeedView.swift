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



struct LeftHeadingSection: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.easeOut(duration: 0.3)) {
                    authViewModel.deleteTokens()
                    authViewModel.validationConfirmed = false
                    authViewModel.opacity = 1
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


private struct MainFeedView: View {
    
    @EnvironmentObject private var feedViewModel: FeedViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    private var actionSheet: ActionSheet {
        ActionSheet(title: Text("Post Options"), message: Text("Choose Option"), buttons: [
            .default(Text("Save")),
            .default(Text("Delete")),
            .cancel()
        ])
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()]) {
                ForEach(feedViewModel.postFeed.indices, id: \.self) { id in
                    PostContentView(post: $feedViewModel.postFeed[id])
                    .contextMenu {
                        PostContextMenu(postId: id)
                    }
                    .background(Color.tertiarySystemBackground)
                    .groupBoxStyle(PostGroupBoxStyle(destination: Text("Post"), post: feedViewModel.postFeed[id]))
                }
                .opacity(feedViewModel.postFeed.isEmpty ? 0 : 1)
                Color.clear.frame(height: 30)
            }
            .padding(.top, 10)
        }
        .onAppear(perform: feedViewModel.fetchFeed)
        .background(colorScheme == .light ? Color(.sRGB, red: 247/255, green: 247/255, blue: 247/255, opacity: 1) : Color(.sRGB, red: 25/255, green: 26/255, blue: 27/255, opacity: 1))
    }
    
    fileprivate func fetchMoreIfNecessary(current: Int) {
        let lastIndex = feedViewModel.postFeed.count - 1
        let shouldLoadMore = lastIndex == current
        if shouldLoadMore {
            feedViewModel.fetchFeed()
        }
    }
    
    
    fileprivate func actionSheetView(postId: Int) -> ActionSheet {
        let targetPost = feedViewModel.postFeed[postId]
        let currentUser = Network.shared.authentication?.username == targetPost.username
        if currentUser {
            return ActionSheet(title: Text("Post Options"), message: nil, buttons: [
                .destructive(Text("Delete"), action: {
                    feedViewModel.deletePost(post: targetPost)
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
