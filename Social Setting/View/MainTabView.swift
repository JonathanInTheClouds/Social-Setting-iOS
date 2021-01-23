//
//  MainTabView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FeedViewList()
                .tabItem {
                    Image(systemName: "cube.fill")
                        .offset(y: 5)
                    Text("Feed")
                }
            
            Color.tertiarySystemBackground.ignoresSafeArea()
                .tabItem {
                    Image(systemName: "quote.bubble.fill")
                    Text("Messages")
                }
        }
        .accentColor(Color.baseColor)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
