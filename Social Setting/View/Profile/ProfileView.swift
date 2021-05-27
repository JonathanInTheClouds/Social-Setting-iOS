//
//  ProfileView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/29/21.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ZStack {
            Color.dynamicBackground.ignoresSafeArea(edges: .all)
            ScrollView {
                VStack {
                    HeaderView()
                        .padding(.horizontal, 16)
                    
                    LazyVStack {
                        Color.separatorOpaque
                            .frame(height: 1, alignment: .center)
                            .opacity(0.5)
//                        PostView()
//                        Color.separatorOpaque
//                            .frame(height: 1, alignment: .center)
//                            .opacity(0.5)
//                        PostView()
//                        Color.separatorOpaque
//                            .frame(height: 1, alignment: .center)
//                            .opacity(0.5)
//                        PostView()
//                        Color.separatorOpaque
//                            .frame(height: 1, alignment: .center)
//                            .opacity(0.5)
//                        PostView()
                    }
                }
                .padding(.top, 16)
            }
        }
        .navigationBarTitle("@Jon_Coder", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .preferredColorScheme(.light)
            
            ProfileView()
                .preferredColorScheme(.dark)
        }
    }
}



extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct HeaderView: View {
    let size = (UIScreen.screenWidth - 32 - (8 * 3)) / 4
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Image("User")
                            .resizable()
                            .frame(width: 64, height: 64, alignment: .center)
                            .cornerRadius(64/2)
                    })
                
                VStack(alignment: .leading) {
                    Text("Jon Dowdell")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.labelPrimary)
                    Text("Software Engineer")
                        .foregroundColor(Color.labelSecondary)
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                    }, label: {
                        Image(systemName: "tray.and.arrow.down.fill")
                            .padding()
                    })
                    .background(Color.fillQuarternary)
                    .frame(width: 44, height: 44, alignment: .center)
                    .cornerRadius(44/2)
                    
                    Button(action: {}, label: {
                        Image(systemName: "capsule")
                            .padding()
                    })
                    .background(Color.fillQuarternary)
                    .frame(width: 44, height: 44, alignment: .center)
                    .cornerRadius(44/2)
                }
            }
            
            Color.separatorOpaque
                .frame(height: 1, alignment: .center)
                .padding(.top, 5)
                .opacity(0.5)
            
            HStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("196")
                        .font(.title2)
                        .bold()
                    Text("POSTS")
                        .foregroundColor(Color.labelTertiary)
                        .font(.footnote)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("1.2M")
                        .font(.title2)
                        .bold()
                    Text("FOLLOWERS")
                        .foregroundColor(Color.labelTertiary)
                        .font(.footnote)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("84")
                        .font(.title2)
                        .bold()
                    Text("FOLLOWING")
                        .foregroundColor(Color.labelTertiary)
                        .font(.footnote)
                }
                
                Spacer()
            }
            
            HStack(spacing: 8) {
                Color.systemGray
                    .frame(width: size, height: size, alignment: .center)
                    .cornerRadius(10)
                
                Color.systemGray
                    .frame(width: size, height: size, alignment: .center)
                    .cornerRadius(10)
                
                Color.systemGray
                    .frame(width: size, height: size, alignment: .center)
                    .cornerRadius(10)
                
                Color.systemGray
                    .frame(width: size, height: size, alignment: .center)
                    .cornerRadius(10)
            }
            
            HStack {
                Text("I’m glad to share my works and these amazing kit with you!")
                    .font(.title3)
                Spacer()
            }
            
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "link")
                    Text("www.jon.d.io")
                })
                
                Spacer()
            }
        }
    }
}
