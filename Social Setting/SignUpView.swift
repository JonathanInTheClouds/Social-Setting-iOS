//
//  SignUpView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/28/21.
//

import SwiftUI

struct SignUpView: View {
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            
            Text("Welcome!")
                .font(.largeTitle)
                .bold()
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 13)
            
            Text("Create your own social network")
                .padding(.bottom, 35)
            
            TextField("Username", text: $username)
                .padding(.horizontal, 11)
                .padding(.vertical, 16)
                .background(Color.fillQuarternary)
                .cornerRadius(10)
            
            TextField("Email", text: $email)
                .padding(.horizontal, 11)
                .padding(.vertical, 16)
                .background(Color.fillQuarternary)
                .cornerRadius(10)
            
            TextField("Password", text: $password)
                .padding(.horizontal, 11)
                .padding(.vertical, 16)
                .background(Color.fillQuarternary)
                .cornerRadius(10)
            
            SocialButton {
                
            } bodyContent: {
                HStack {
                    Spacer()
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding(.vertical, 5)
            }
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.top)

            
        }
        .padding(.horizontal, 30)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView().preferredColorScheme(.light)
            
            SignUpView().preferredColorScheme(.dark)
        }
    }
}
