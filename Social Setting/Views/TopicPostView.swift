//
//  TopicPostView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI

struct TopicPostView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            PostHeadView()
            MainBody()
            Color.gray39
                .frame(height: 1, alignment: .center)
                .padding(.top, 15)
            ButtonHStack()
        }
    }
}

struct TopicPostView_Previews: PreviewProvider {
    static var previews: some View {
        TopicPostView()
            .padding(.horizontal, 16)
    }
}


private struct MainBody: View {
    
    var body: some View {
        // TODO: - Remove Range Block
        if (Int.random(in: 0..<10)) % 2 == 0 {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image("placeholder-photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180, alignment: .center)
                    .cornerRadius(6)
                    .clipped()
            })
        }
        
        Text("Openly admit that you don’t know something")
            .font(.system(size: 24))
            .foregroundColor(Color.gray99)
            .padding(.bottom, 10)
        
        Text("If you don’t have any knowledge about the topic, admit it openly that you don’t know.")
            .font(.system(size: 16))
            .foregroundColor(Color.gray99)
    }
}
