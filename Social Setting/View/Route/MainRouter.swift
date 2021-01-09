//
//  MainRouter.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/2/21.
//

import SwiftUI

struct MainRouter: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if authViewModel.savedAuthentication != nil || authViewModel.authentication != nil {
            MainTabView()
//            VStack(spacing: 20) {
//                Button(action: {
//                    authViewModel.signOut()
//                }, label: {
//                    Text("Sign Out")
//                })
//
//                Button(action: {
//                    authViewModel.getSubSettingFeed(0)
//                }, label: {
//                    Text("Get Feed")
//                })
//            }
        } else {
            SignInView()
        }
    }
}

