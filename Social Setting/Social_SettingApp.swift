//
//  Social_SettingApp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/13/20.
//

import SwiftUI

@main
struct Social_SettingApp: App {
    let persistenceController = PersistenceController.shared
    var authViewModel = AuthViewModel()
    var postViewModel = PostViewModel()
    var feedViewModel = FeedViewModel()
    
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(Color.baseColor)
    }

    var body: some Scene {
        WindowGroup {
            MainRoute()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(authViewModel)
                .environmentObject(postViewModel)
                .environmentObject(feedViewModel)
                .onAppear(perform: {
                    UITextView.appearance().backgroundColor = .clear
                })
        }
    }
}
