//
//  PostHeadView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct PostHeadView<V: View>: View {
    
    @EnvironmentObject var feedViewModel: FeedViewModel
    
    var destination: V
    
    var post: PostResponse
    
    var body: some View {
        HStack {
            ProfileImage(buttonSize: 50, imageSize: 20, destination: Text("Hello World"))
            
            VStack(alignment: .leading, spacing: 2) {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text(post.username)
                            .foregroundColor(.gray99)
                            .font(.callout)
                    })
                
                Text(post.duration)
                    .foregroundColor(.gray79)
                    .font(.caption)
            }
            
            NavigationLink(
                destination: Text("Post"),
                label: {
                    Color.clear
                })
            
            Button(action: {
                print(post.postName)
                feedViewModel.setDeletablePost(post: post)
                feedViewModel.showActionSheet.toggle()
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
        PostHeadView(destination: Text("Hello World"), post: MockData.post[0])
    }
}
