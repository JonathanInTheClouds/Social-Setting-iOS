//
//  MainTabView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/15/20.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Feed")
                }
            FeedView()
                .tabItem {
                    Image(systemName: "quote.bubble.fill")
                    Text("Messages")
                }
            FeedView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Activity")
                }
            FeedView()
                .tabItem {
                    Image(systemName: "doc.richtext.fill")
                    Text("Profile")
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
