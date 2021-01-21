//
//  PostCreateViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/12/21.
//

import Foundation

class PostCreateViewModel: ObservableObject {
    
    @Published var subSettingName: String?
    
    @Published var selection: Int = 0
    
    @Published var titleText: String = ""
    
    @Published var titleEditing: Bool = false
    
    @Published var bodyText: String = ""
    
    @Published var bodyEditing: Bool = false
    
    init() {
        let userDefaults = UserDefaults.standard
        guard let savedSubSettingName = userDefaults.object(forKey: "SelectedSubSetting") as? String else {
            guard let auth = SocialSettingAPI.agent.savedAuthentication else { return }
            subSettingName = auth.username
            return
        }
        subSettingName = savedSubSettingName
    }
    
    deinit {
        print("PostCreateViewModel ☠️ Killed")
    }
}
