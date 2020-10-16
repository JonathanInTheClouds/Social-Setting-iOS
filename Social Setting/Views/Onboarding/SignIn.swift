//
//  SignUp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/13/20.
//

import SwiftUI
import TextView

struct SignIn: View {
    
    @State var username: String = ""
    
    @State var password: String = ""
    
    @State var userEditing: Bool = true
    
    @State var passwordEditing: Bool = false
    
    @State var signInComplete: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.tertiarySystemBackground
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HeadView()
                        .padding(.bottom, 30)
                        .modifier(DismissingKeyboard())

                    TextView(text: $username, isEditing: $userEditing, placeholder: "Username",
                             textHorizontalPadding: -4, textVerticalPadding: 0,
                             placeholderHorizontalPadding: -1, placeholderVerticalPadding: 1, returnType: UIReturnKeyType.next, shouldChange: { _, character -> Bool in
                                let isEntered = character == "\n"
                                if isEntered {
                                    userEditing.toggle()
                                    passwordEditing.toggle()
                                }
                                return isEntered ? false : true
                             })
                        .frame(height: 21, alignment: .center)
                        .padding()
                        .background(Color.gray19)
                        .cornerRadius(6)
                        .keyboardType(.default)
                        .padding(.bottom, 5)
                    
                    
                    TextView(text: $password, isEditing: $passwordEditing, placeholder: "Password",
                             textHorizontalPadding: -4, textVerticalPadding: 0,
                             placeholderHorizontalPadding: -1, placeholderVerticalPadding: 1, returnType: UIReturnKeyType.continue, shouldChange: { _, character -> Bool in
                                let isEntered = character == "\n"
                                
                                if isEntered {
                                    passwordEditing.toggle()
                                }
                                
                                return isEntered ? false : true
                             })
                        .frame(height: 21, alignment: .center)
                        .padding()
                        .background(Color.gray19)
                        .cornerRadius(6)
                        .keyboardType(.default)
                        .padding(.bottom, 15)
                    
                    HStack(spacing: 10) {
                        MainNavigationLinkView(action: {
                            signInComplete = true
                        }, destionation: SignUp(), title: "Sign In", shouldPush: $signInComplete)
                    
                        AltNavigationLinkView(action: {
                            
                        }, destination: SignUp(), leftText: "Sign Up", rightImage: Image(systemName: "chevron.right"))
                    }
                    
                }
                .padding(.all, 30)
                .navigationBarHidden(true)
                .modifier(DismissingKeyboard())
            }
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    
    @State static var field = ""
    
    static var previews: some View {
        Group {
            SignIn()
                .environment(\.colorScheme, .light)
            
            SignIn()
                .environment(\.colorScheme, .dark)
        }
    }
}

struct HeadView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Welcome to\nSocial Setting")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray99)
                    .bold()
                
                Spacer()
                
                Image("large-logo")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fit)
            }
            
            Text("In a world of mixed sentiment \ndo you stand out")
                .foregroundColor(Color.gray99)
                .fixedSize()
                .padding(.bottom, 20)
        }
    }
}
