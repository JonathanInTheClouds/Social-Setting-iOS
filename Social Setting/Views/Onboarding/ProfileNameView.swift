//
//  ProfileNameView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/20/20.
//

import SwiftUI

struct ProfileNameView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var profileName: String = ""
    
    @State var profileNameEditing: Bool = false
    
    @State var shouldPush: Bool = false
    
    @State var opacity: Double = 1
    
    var body: some View {
        ZStack {
            Color.tertiarySystemBackground
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HeadView()
                    .padding(.bottom, 30)
                    .modifier(DismissingKeyboard())
                
                SSTextView(field: $profileName, fieldEditing: $profileNameEditing, placeholder: "Profile Name", returnType: .continue, keyboardType: .default, enterAction: {
                })
                .padding(.bottom, 15)
                
                MainNavigationLinkView(action: sendProfileData, destionation: SignUpView(), title: "Done", shouldPush: $shouldPush)
                
            }
            .padding(.horizontal, 30)
            .navigationBarHidden(true)
            .modifier(DismissingKeyboard())
            .opacity(opacity).onAnimationCompleted(for: opacity) {
                withAnimation(.easeIn(duration: 0.5)) {
                    self.authViewModel.validationConfirmed = true
                }
            }
        }
    }
    
    func sendProfileData() {
        
        authViewModel.sendProfileData(profileName: profileName) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    withAnimation(.easeIn(duration: 0.5)) {
                        opacity = 0
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ProfileName_Previews: PreviewProvider {
    static var previews: some View {
        ProfileNameView()
        
    }
}

private struct HeadView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Give your profile \na name and photo")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray99)
                    .bold()
                    .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ProfileImage(buttonSize: 60, imageSize: 20)
                })
            }
            
            Text("Maybe something like your nick name or what friends call you")
                .foregroundColor(Color.gray99)
                .padding(.top, 15)
        }
    }
}
