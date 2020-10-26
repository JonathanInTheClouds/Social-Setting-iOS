//
//  SecureCodeView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI

struct SecureCodeView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var secureCode: String = ""
    
    @State var secureCodeEditing: Bool = false
    
    @State var codeVerified: Bool = false
    
    @State var opacity: Double = 1
    
    var body: some View {
        ZStack {
            Color.tertiarySystemBackground
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HeadView()
                SSTextView(field: $secureCode, fieldEditing: $secureCodeEditing, placeholder: "Secure Code", returnType: .send, keyboardType: .decimalPad, enterAction: {
                    secureCodeEditing = false
                })
                .padding(.top, 35)
                .padding(.bottom, 10)
                
                HStack {
                    Text("Available in about 15 seconds")
                        .foregroundColor(Color.gray79)
                        .font(.footnote)
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Resend Code")
                            .font(.footnote)
                            .foregroundColor(Color.baseColor)
                    })
                }
                .padding(.bottom, 15)
                
                MainNavigationLinkView(action: sendCode, destionation: ProfileNameView(), title: "Send", shouldPush: $codeVerified)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            .modifier(DismissingKeyboard())
        }
        .navigationBarBackButtonHidden(true)
        .opacity(opacity).onAnimationCompleted(for: opacity) {
            withAnimation(.easeIn(duration: 0.5)) {
                self.authViewModel.validationConfirmed = true
            }
        }
    }
    
    func sendCode() {
        let code = Int(secureCode) ?? 0
        if code != 0 {
            authViewModel.validateSecureCode(code: code) { (result) in
                switch result {
                case .success(let authResp):
                    print(authResp)
                    DispatchQueue.main.async {
                        withAnimation {
                            opacity = 0
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct SecureCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SecureCodeView()
        
    }
}

private struct HeadView: View {
    var body: some View {
        HStack {
            Text("Enter secure \ncode to verify")
                .bold()
                .font(.largeTitle)
                .foregroundColor(Color.gray99)
                .fixedSize()
        

            Spacer()
            Image("check-mark")
                .offset(y: -50)
        }
        
        Text("Please check email for email \nvalidation code")
            .fixedSize()
            .foregroundColor(Color.gray99)
    }
}
