//
//  PostCommentView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/8/21.
//

import SwiftUI
import ASCollectionView

struct PostCommentView: View {
    
    @Binding var post: PostResponse
    
    var body: some View {
        DynamicBackground {
            ASCollectionView {
                PostFeedView(post: $post)
                    .groupBoxStyle(PostGroupBoxStyle(destination: Text(""), post: post))
            }
            .alwaysBounceVertical()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Spacer()
                    Button(action: {
                        Vibration.light.vibrate()
                    }, label: {
                        Image("large-logo")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                    })
                }
            }
        }
    }
}

struct PostCommentView_Previews: PreviewProvider {
    static var previews: some View {
        PostCommentView(post: .constant(MockData.post[0]))
    }
}
