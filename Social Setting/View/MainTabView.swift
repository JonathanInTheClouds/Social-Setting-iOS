//
//  MainTabView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/11/21.
//

import SwiftUI

struct MainTabView: View {
    
    @ObservedObject var themeController = ThemeSettingsController()
    
    var body: some View {
        TabView {
            MainFeedView(viewModel: FeedViewModel())
                .environmentObject(themeController)
                .accentColor(themeController.mainTint)
                .tabItem {
                    Label("Today", systemImage: "house")
                }
            
            NavigationView {
                ProfileView()
                    .environmentObject(themeController)
                    .accentColor(themeController.mainTint)
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
            
            SettingsView()
                .environmentObject(themeController)
                .accentColor(themeController.mainTint)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }.accentColor(themeController.mainTint)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
