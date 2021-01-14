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
        do {
            let savedSubSetting = try userDefaults.getObject(forKey: "SelectedSubSetting", castTo: SubSettingResponse.self)
            subSettingName = savedSubSetting.name
        } catch {
            guard let auth = SocialSettingAPI.agent.savedAuthentication else { return }
            subSettingName = auth.username
        }
    }
    
    deinit {
        print("PostCreateViewModel ☠️ Killed")
    }
    
    func reload() {
        let userDefaults = UserDefaults.standard
        do {
            let savedSubSetting = try userDefaults.getObject(forKey: "SelectedSubSetting", castTo: SubSettingResponse.self)
            subSettingName = savedSubSetting.name
        } catch {
            guard let auth = SocialSettingAPI.agent.savedAuthentication else { return }
            subSettingName = auth.username
        }
    }
}
