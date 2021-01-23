//
//  FeedNavigationLogo.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/23/21.
//

import SwiftUI

struct FeedNavigationLogo: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.easeOut(duration: 0.3)) {
                    authViewModel.signOut()
                }
            } label: {
                Image("large-logo")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                Text("Social Setting")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.gray99)
            }
        }
    }
}

struct FeedNavigationLogo_Previews: PreviewProvider {
    static var previews: some View {
        FeedNavigationLogo()
    }
}
