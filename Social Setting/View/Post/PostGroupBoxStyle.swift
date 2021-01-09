//
//  PostGroupBoxStyle.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI


struct PostGroupBoxStyle<V: View>: GroupBoxStyle {
    
    var destination: V
    
    var post: PostResponse
    
    func makeBody(configuration: Configuration) -> some View {
        GroupBox(label: PostHeadView(destination: destination, post: post), content: {
            configuration.content
        })
    }
    
}
