//
//  Post.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/14/20.
//

import SwiftUI

struct PostContentView: View {
    
    
    var body: some View {
        // TODO: - Remove Range Block
        if Int.random(in: 1...10) % 2 == 0 {
            NormalPostView()
        } else {
            TopicPostView()
        }
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        PostContentView()
    }
}

