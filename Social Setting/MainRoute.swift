//
//  MainRoute.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/19/20.
//

import SwiftUI
import iTextField

struct MainRoute: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if authViewModel.validationConfirmed || authViewModel.token != nil {
                MainTabView()
            } else {
                SignInView()
            }
        }
    }
}

struct MainRoute_Previews: PreviewProvider {
    static var previews: some View {
        MainRoute()
    }
}

typealias PlainTextView = iTextField
