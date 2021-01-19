//
//  Social_SettingApp.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import SwiftUI
import iTextField

@main
struct Social_SettingApp: App {
    let persistenceController = PersistenceController.shared
    let authViewModel = AuthViewModel()
    let postViewModel = PostViewModel()
    let feedViewModel = FeedViewModel()
    let commentPopupHelper = CommentPopupHelper()
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(Color.baseColor)
        UITextView.appearance().tintColor = UIColor(Color.baseColor)
        UITextField.appearance().tintColor = UIColor(Color.baseColor)
        UITabBar.appearance().tintColor = UIColor(Color.baseColor)
    }

    var body: some Scene {
        WindowGroup {
            MainRouter()
                .environmentObject(authViewModel)
                .environmentObject(feedViewModel)
                .environmentObject(postViewModel)
                .environmentObject(commentPopupHelper)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

typealias PlainTextView = iTextField
