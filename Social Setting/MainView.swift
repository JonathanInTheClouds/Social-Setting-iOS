//
//  MainView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/27/21.
//

import SwiftUI

struct MainView: View {
    
    @State var presentingSignUpPage: Bool = false
    
    @State var presentingLoginPage: Bool = false
    
    var body: some View {
        VStack {
            Text("Discover article,\n news & posts")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Rectangle()
                .frame(height: 311, alignment: .center)
                .cornerRadius(8)
                .foregroundColor(Color.fillQuarternary)
                .padding(.bottom)

            VStack(spacing: 10) {
                SocialButton(action: {
                    
                }, bodyContent: {
                    HStack {
                        Image("Google Logo")
                            .resizable()
                            .frame(width: 19.85, height: 18.31, alignment: .center)
                            .foregroundColor(Color.labelSecondary)
                        
                        Spacer()
                        
                        Text("Continue with Google")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.labelSecondary)
                        
                        Spacer()
                        
                        Image("Google Logo")
                            .resizable()
                            .frame(width: 19.85, height: 18.31, alignment: .center)
                            .foregroundColor(Color.labelSecondary)
                            .opacity(0)
                    }
                })
                .cornerRadius(10)
                
                SocialButton(action: {
                    
                }, bodyContent: {
                    HStack {
                        Image("Apple Logo")
                            .resizable()
                            .frame(width: 16, height: 19, alignment: .center)
                            .foregroundColor(Color.labelSecondary)
                        
                        Spacer()
                        
                        Text("Continue with Apple")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.labelSecondary)
                        
                        Spacer()
                        
                        Image("Apple Logo")
                            .resizable()
                            .frame(width: 16, height: 19, alignment: .center)
                            .foregroundColor(Color.labelSecondary)
                            .opacity(0)
                    }
                })
                .cornerRadius(10)
                
                SocialButton(action: {
                    presentingSignUpPage = true
                }, bodyContent: {
                    HStack {
                        Spacer()
                        
                        Text("Sign Up")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                })
                .background(Color.blue)
                .cornerRadius(10)
                .sheet(isPresented: $presentingSignUpPage, content: {
                    SignUpView()
                })
                
                Button(action: {
                    presentingLoginPage = true
                }, label: {
                    HStack {
                        Text("Have an account?")
                            .foregroundColor(.gray)
                        Text("Log In")
                            .bold()
                    }
                    .padding(.all)
                })
                .sheet(isPresented: $presentingLoginPage, content: {
                    SignInView()
                })
            }
            
        }
        .padding(.horizontal, 32)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    

    
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
