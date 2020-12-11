//
//  PostMainBody.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/10/20.
//

import SwiftUI

struct PostMainBody: View {
    
    var photoURL: String?
    
    var post: PostResponseModel
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.postName)
                .bold()
                .font(.system(size: 24))
                .foregroundColor(Color.gray99)
                .padding(.bottom, 10)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                Text(post.description)
                    .font(.body)
                    .foregroundColor(Color.gray99)
                Spacer()
            }
            if photoURL != nil { // Temp
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("placeholder-photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180, alignment: .center)
                        .cornerRadius(6)
                        .clipped()
                })
            }
        }
    }
}

struct PostMainBody_Previews: PreviewProvider {
    static var previews: some View {
        PostMainBody(post: MockData.posts[0])
    }
}
