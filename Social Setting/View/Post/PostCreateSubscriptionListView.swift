//
//  PostCreateSubscriptionListView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/10/21.
//

import SwiftUI
import SwiftKeychainWrapper

struct PostCreateSubscriptionListView: View {
    
    @ObservedObject var postCreateSubscriptionListViewModel = PostCreateSubscriptionListViewModel()
    
    @Binding var subSettingName: String?
    
    @State var tempSubSettingName = ""
    
    var body: some View {
        List {
            
            if let currentUser = postCreateSubscriptionListViewModel.savedAuthentication {
                Button {
                    tempSubSettingName = currentUser.username
                    UserDefaults.standard.set(tempSubSettingName, forKey: "SelectedSubSetting")
                } label: {
                    HStack {
                        Text(currentUser.username)
                        Spacer()
                        if let name = subSettingName, (currentUser.username == name && tempSubSettingName.isEmpty) || (currentUser.username == tempSubSettingName) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            
            ForEach(postCreateSubscriptionListViewModel.subSettingList) { item in
                Button {
                    tempSubSettingName = item.name
                    UserDefaults.standard.set(tempSubSettingName, forKey: "SelectedSubSetting")
                } label: {
                    HStack {
                        Text(item.name)
                        Spacer()
                        if let name = subSettingName, (item.name == name && tempSubSettingName.isEmpty) || (item.name == tempSubSettingName) {
                            Image(systemName: "checkmark")
                        }
                    }
                }

            }
        }
        .onDisappear {
            withAnimation(.spring()) { 
                subSettingName = tempSubSettingName
            }
        }
    }
}
