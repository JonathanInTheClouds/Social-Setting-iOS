//
//  Social_SettingApp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/27/21.
//

import SwiftUI

@main
struct Social_SettingApp: App {
    
    let themeController = ThemeSettingsController()
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

