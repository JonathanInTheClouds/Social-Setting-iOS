//
//  PostContentView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/10/20.
//

import SwiftUI

struct PostContentView: View {
    
    @Binding var post: PostResponseModel
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                NavigationLink(destination: Text("Post")) {
                    PostMainBody(photoURL: nil, post: post)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom)
                Color.gray39
                    .frame(height: 1, alignment: .center)
                PostButtonHStack(post: $post)
            }
        }
    }
}

struct PostContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostContentView(post: .constant(MockData.posts[0]))
    }
}
