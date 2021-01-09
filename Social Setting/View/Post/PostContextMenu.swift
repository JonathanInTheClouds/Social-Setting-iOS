//
//  PostContextMenu.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct PostContextMenu: View {
    var body: some View {
        VStack {
            Button(action: { }, label:
            {
                HStack {
                    Text("Save")
                    Image(systemName: "checkmark.rectangle.portrait.fill")
                }
            })
            
            Button(action: {}, label:
            {
                HStack {
                    Text("Like")
                    Image(systemName: "suit.heart.fill")
                }
            })
        }
    }
}

struct PostContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        PostContextMenu()
    }
}
