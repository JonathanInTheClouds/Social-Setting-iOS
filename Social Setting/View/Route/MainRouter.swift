//
//  MainRouter.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/2/21.
//

import SwiftUI

struct MainRouter: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var commentPopupHelper: CommentPopupHelper
    
    var body: some View {
        if authViewModel.savedAuthentication != nil || authViewModel.authentication != nil {
            MainTabView()
        } else {
            SignInView()
        }
    }
}

