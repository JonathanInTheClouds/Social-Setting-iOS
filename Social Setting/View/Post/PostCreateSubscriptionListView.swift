//
//  PostCreateSubscriptionListView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/10/21.
//

import SwiftUI

struct PostCreateSubscriptionListView: View {
    
    @ObservedObject var postCreateSubscriptionListViewModel = PostCreateSubscriptionListViewModel()
    
    @Binding var username: String?
    
    @State var subSettingId: Int64 = -0
    
    var body: some View {
        List {
//            ForEach(postCreateSubscriptionListViewModel.subSettingList.indices) { index in
//                PostCreateSubscriptionCell(selectedSubSetting: $postCreateSubscriptionListViewModel.selectedSubSetting, subSetting: $postCreateSubscriptionListViewModel.subSettingList[index])
//            }
            ForEach(postCreateSubscriptionListViewModel.subSettingList) { item in
                Button {
                    subSettingId = item.id
                    let userDefaults = UserDefaults.standard
                    do {
                        try userDefaults.setObject(item, forKey: "SelectedSubSetting")
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    HStack {
                        Text(item.name)
                            .bold()
                        Spacer()
                        if item.id == subSettingId {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        }
        .navigationTitle("SubSettings")
    }
}


private struct PostCreateSubscriptionCell: View {
    
    @Binding var selectedSubSetting: SubSettingResponse?
    
    @Binding var subSetting: SubSettingResponse
    
    var body: some View {
        Button(action: {
            selectedSubSetting = subSetting
            let userDefaults = UserDefaults.standard
            do {
                try userDefaults.setObject(subSetting, forKey: "SelectedSubSetting")
            } catch {
                print(error.localizedDescription)
            }
        }, label: {
            HStack {
                Text(subSetting.name)
                    .bold()
                Spacer()
                if subSetting.id == selectedSubSetting?.id {
                    Image(systemName: "checkmark")
                }
            }
        })
    }
}
