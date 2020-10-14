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
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(Color.baseColor)
    }

    var body: some Scene {
        WindowGroup {
            SignIn()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
