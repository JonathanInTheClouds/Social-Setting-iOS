//
//  PostHeaderView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/23/21.
//

import SwiftUI

struct PostHeaderView: View {
    
    @Binding var showProfile: Bool
    
    @Binding var post: PostResponse
    
    var body: some View {
        HStack {
            ProfileImageButton(showProfile: $showProfile)
            Button(action: {
                showProfile = true
            }, label: {
                Text(post.username)
                    .font(.system(size: 20, weight: .bold, design: Font.Design.rounded))
                    .foregroundColor(.gray99)
            })
            .buttonStyle(PlainButtonStyle())
            Spacer()
            Text(post.duration)
                .foregroundColor(.gray79)
                .font(.caption)
        }
    }
}

struct PostHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PostHeaderView(showProfile: .constant(false), post: .constant(MockData.post[0]))
    }
}
