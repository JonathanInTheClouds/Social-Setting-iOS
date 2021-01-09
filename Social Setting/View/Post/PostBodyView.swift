//
//  PostBodyView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct PostBodyView: View {
    
    var post: PostResponse
    
    var photoURL: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.postName)
                .bold()
                .font(.system(size: 24))
                .foregroundColor(.gray99)
                .padding(.bottom, 10)
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                Text(post.description)
                    .font(.body)
                    .foregroundColor(.gray99)
                Spacer()
            }
            
            if photoURL != nil {
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
        .frame(maxWidth: .infinity)
    }
}

struct PostBodyView_Previews: PreviewProvider {
    static var previews: some View {
        PostBodyView(post: MockData.post[0])
    }
}
