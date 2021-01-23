//
//  ProfileImageButton.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/23/21.
//

import SwiftUI


struct ProfileImageButton: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: {
            showProfile = true
        }, label: {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                VStack {
                    Text("JD")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 40, height: 40, alignment: .center)
        })
    }
}
