//
//  StoryItem.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/10/21.
//

import SwiftUI

struct StoryItem: View {
    
    let addingItem: Bool
    
    let username: String
    
    init(addingItem: Bool = false, username: String = "") {
        self.addingItem = addingItem
        self.username = username
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.accentColor)
                    .frame(width: 64, height: 64, alignment: .center)
                
                Image("User")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                
                if addingItem {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack {
                                Color.white
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .foregroundColor(.accentColor)
                            }
                            .cornerRadius(20)
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(.trailing, 10)
                        }
                    }
                }
            }
            
            if addingItem {
                Text("Add Story")
            } else {
                Text(username)
            }
        }
        .frame(width: 80, height: 93, alignment: .center)
    }
}

struct StoryItem_Previews: PreviewProvider {
    static var previews: some View {
        StoryItem()
    }
}
