//
//  PostCreateSubscriptionListViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/12/21.
//

import Foundation
import Combine

class PostCreateSubscriptionListViewModel: ObservableObject {
    
    @Published var subSettingList = [SubSettingResponse]()
    
    @Published var selectedSubSetting: SubSettingResponse? = nil
    
    private var subSettingListCancellable: AnyCancellable?
    
    private var page: Int = 0
    
    init() {
        getSubSettingSubscriptions()
        let userDefaults = UserDefaults.standard
        do {
            let savedSubSetting = try userDefaults.getObject(forKey: "SelectedSubSetting", castTo: SubSettingResponse.self)
            self.selectedSubSetting = savedSubSetting
            print(savedSubSetting)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    deinit {
        print("PostCreateSubscriptionListViewModel Killed - ☠️")
    }
    
    func getSubSettingSubscriptions() {
        subSettingListCancellable = SocialSettingAPI.getSubscribedSubsettingList(page: page)
            .sink(receiveCompletion: { print($0) }, receiveValue: {
                if !$0.isEmpty {
                    self.subSettingList.append(contentsOf: $0)
                    self.page += 1
                }
            })
    }
    
}
