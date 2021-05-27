//
//  SignInView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/29/21.
//

import SwiftUI

struct SignInView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            
            Text("Welcome Back!")
                .font(.largeTitle)
                .bold()
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 13)
            
            Text("Manage your own social network")
                .padding(.bottom, 35)
            
            TextField("Username", text: $username)
                .padding(.horizontal, 11)
                .padding(.vertical, 16)
                .background(Color.fillQuarternary)
                .cornerRadius(10)
            
            TextField("Password", text: $password)
                .padding(.horizontal, 11)
                .padding(.vertical, 16)
                .background(Color.fillQuarternary)
                .cornerRadius(10)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                HStack {
                    Spacer()
                    Text("Forgot Password?")
                }
            })
            
            SocialButton {
                
            } bodyContent: {
                HStack {
                    Spacer()
                    Text("Log In")
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
