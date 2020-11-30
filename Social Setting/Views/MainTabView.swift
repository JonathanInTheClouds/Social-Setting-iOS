//
//  MainTabView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/15/20.
//

import SwiftUI

struct MainTabView: View {
    
    var username: String = ""
    
    var body: some View {
        TabView {
            FeedView()
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
            Color.tertiarySystemBackground.ignoresSafeArea()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Activity")
                }
            ProfileView(username: username)
                .tabItem {
                    Image(systemName: "mail.fill")
                    Text("Profile")
                }
        }
        .accentColor(Color.baseColor)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabView()
                .environment(\.colorScheme, .light)
            
            MainTabView()
                .environment(\.colorScheme, .dark)
        }
    }
}
