//
//  CreatePostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/26/20.
//

import SwiftUI

struct CreatePostView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.tertiarySystemBackground.ignoresSafeArea()
            }
            .navigationTitle(Text("Create Post"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "shippingbox.fill")
            }))
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreatePostView()
        }
    }
}
