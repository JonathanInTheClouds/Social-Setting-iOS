//
//  PostCreateSubscriptionListViewModel.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/12/21.
//

import Foundation
import Combine

class PostCreateSubscriptionListViewModel: ObservableObject, AuthTokenProtocol {
    
    @Published var subSettingList = [SubSettingResponse]()
    
    @Published var selectedSubSetting: String? = nil
    
    private var subSettingListCancellable: AnyCancellable?
    
    private var page: Int = 0
    
    init() {
        getSubSettingSubscriptions()
        let userDefaults = UserDefaults.standard
        do {
            let savedSubSetting = try userDefaults.getObject(forKey: "SelectedSubSetting", castTo: String.self)
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
            .sink(receiveCompletion: { print($0) }, receiveValue: { [weak self] subSettingResponse in
                if !subSettingResponse.isEmpty {
                    self?.subSettingList.append(contentsOf: subSettingResponse)
                    self?.page += 1
                }
            })
    }
    
}
