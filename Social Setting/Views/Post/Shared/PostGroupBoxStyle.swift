//
//  PostGroupBoxStyle.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/10/20.
//

import SwiftUI

struct PostGroupBoxStyle<V: View>: GroupBoxStyle {
    
    var destination: V
    
    var post: PostResponseModel
    
    
    func makeBody(configuration: Configuration) -> some View {
        GroupBox(label: PostHeadMainView(destination: destination, post: post), content: {
            configuration.content
        })
    }
    
}

private struct PostHeadMainView<V: View>: View {
    
    var destination: V
    
    var post: PostResponseModel
    
    var body: some View {
        HStack(spacing: 10) {
            ProfileImage(buttonSize: 50, imageSize: 20, destination: destination)
            
            VStack(alignment: .leading) {
                NavigationLink(
                    destination: destination) {
                    Text(post.username)
                        .foregroundColor(Color.gray99)
                        .font(.callout)
                }
                
                Text(post.duration)
                    .foregroundColor(Color.gray79)
                    .font(.caption)
            }
            
            Spacer()
            
            Button(action: {
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
