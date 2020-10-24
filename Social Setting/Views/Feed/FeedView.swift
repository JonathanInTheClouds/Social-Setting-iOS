//
//  Feed.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/14/20.
//

import SwiftUI
import SwiftKeychainWrapper

struct FeedView: View {
    
    @ObservedObject var feedViewModel: FeedViewModel = FeedViewModel()
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject private var searchBar: SearchBar = SearchBar()
    
    @State private var searchText : String = ""
    
    fileprivate func fetchMoreIfNecessary(current: Int) {
        let lastIndex = feedViewModel.postFeed.count - 1
        let shouldLoadMore = lastIndex == current
        if shouldLoadMore {
            feedViewModel.fetchFeed()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.tertiarySystemBackground
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack {
                        // TODO: - Add Functionality
                        ForEach(feedViewModel.postFeed.indices, id: \.self) { id in
                            PostContentView(post: $feedViewModel.postFeed[id])
                                .padding(.horizontal, 16)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .onAppear {fetchMoreIfNecessary(current: id)}
                            Separator()
                        }
                    }
                    .padding(.top, 5)
                }
                .add(self.searchBar)
                .navigationBarItems(leading: HStack {
                    Image("large-logo")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                    Text("Social Setting")
                        .foregroundColor(Color.gray99)
                }, trailing: HStack {
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.3)) {
                            KeychainWrapper.standard.remove(forKey: "auth_token")
                            authViewModel.validationConfirmed = false
                        }
                    }, label: {
                        Image(systemName: "rectangle.fill.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23, height: 23, alignment: .center)
                    })
                })
                .navigationBarTitleDisplayMode(.inline)
            }
        }
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
