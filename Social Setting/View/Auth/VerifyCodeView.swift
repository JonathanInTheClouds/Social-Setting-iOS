//
//  VerifyCodeView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/3/21.
//

import SwiftUI

struct VerifyCodeView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var secureCode = ""
    @State var secureCodeEditing = true
    
    var body: some View {
        DynamicBackground(.horizontal, 30, alignment: .center) {
            HeadView()
                .padding(.bottom, 10)
            
            StandardInputView(field: $secureCode, fieldEditing: $secureCodeEditing, placeholder: "Secure Code",
                              keyboardType: .numberPad) {
                
            }
            
            HStack(spacing: 10) {
                MainButtonView(shouldPush: .constant(false), title: "Send Code", destionation: Text("")) {
                    guard let securCode = Int32(secureCode) else { return }
                    authViewModel.verifyCode(verifyCodeRequest: VerifyCodeRequest(code: securCode))
                }
                
                AltButtonView(leftText: "Resend", rightImage: Image(systemName: "arrow.uturn.left"), destination: SignUpView()) {
                    
                }
            }
            .padding(.top, 10)
        }
    }
}

struct VerifyCodeView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyCodeView()
    }
}

private struct HeadView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top) {
                Text("Enter secure \ncode to verify")
                    .font(.largeTitle)
                    .foregroundColor(.labelColor)
                
                Spacer()
                
                Image("Info")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            Text("We just want to make sure you're not a bot")
                .foregroundColor(Color.labelColor)
                .fixedSize()
                .padding(.bottom, 20)
        }
    }
}
