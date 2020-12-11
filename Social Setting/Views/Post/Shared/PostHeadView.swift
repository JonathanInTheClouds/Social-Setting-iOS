//
//  PostHeadView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/10/20.
//

import SwiftUI


struct PostHeadView: View {
    
    @EnvironmentObject private var feedViewModel: FeedViewModel
    
    var username: String
    
    var timeAgo: String
    
    
    var body: some View {
        HStack {
            ProfileImage(buttonSize: 50, imageSize: 20, destination: Text("Hello World"))
            
            VStack(alignment: .leading, spacing: 2) {
                NavigationLink(destination: ProfileView(username: username).environmentObject(ProfileViewModel())) {
                    Text(username)
                        .foregroundColor(Color.gray99)
                        .font(.callout)
                }
                Text(timeAgo)
                    .foregroundColor(Color.gray79)
                    .font(.caption)
            }
            
            Spacer()
            
            Button(action: {
                feedViewModel.shoudShowMenu = true
                print("Clicked")
            }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color.gray79)
                }
                .frame(width: 50, height: 50, alignment: .center)
            })
        }
    }
}


struct PostHeadView_Previews: PreviewProvider {
    static var previews: some View {
        PostHeadView(username: "Metta", timeAgo: "just now")
    }
}
