//
//  Social_SettingApp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/27/21.
//

import SwiftUI

@main
struct Social_SettingApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainFeedView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

