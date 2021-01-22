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
    
    fileprivate func listItem(_ targetName: String) -> Button<HStack<TupleView<(Text, Spacer, Image?)>>> {
        return Button {
            tempSubSettingName = targetName
            UserDefaults.standard.set(tempSubSettingName, forKey: "SelectedSubSetting")
        } label: {
            HStack {
                Text(targetName)
                Spacer()
                if let name = subSettingName, (targetName == name && tempSubSettingName.isEmpty) || (targetName == tempSubSettingName) {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
    
    var body: some View {
        List {
            
            if let targetName = postCreateSubscriptionListViewModel.savedAuthentication?.username {
                listItem(targetName)
            }
            
            ForEach(postCreateSubscriptionListViewModel.subSettingList) { item in
                listItem(item.name)
            }
        }
        .onDisappear {
            withAnimation(.spring()) { 
                subSettingName = tempSubSettingName
            }
        }
    }
}
