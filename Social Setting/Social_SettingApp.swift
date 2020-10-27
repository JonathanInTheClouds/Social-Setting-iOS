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
    
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(Color.baseColor)
    }

    var body: some Scene {
        WindowGroup {
            MainRoute()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(authViewModel)
                .onAppear(perform: {
                    UITextView.appearance().backgroundColor = .clear
                })
        }
    }
}
