//
//  MainRoute.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/19/20.
//

import SwiftUI

struct MainRoute: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            if !authViewModel.validationConfirmed {
                SignInView()
            } else {
                MainTabView()
            }
        }
    }
}

struct MainRoute_Previews: PreviewProvider {
    static var previews: some View {
        MainRoute()
    }
}
