//
//  FeedCreatePostButton.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/23/21.
//

import SwiftUI

struct FeedCreatePostButton: View {
    
    @EnvironmentObject private var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack {
            Button {
                feedViewModel.createPostIsPresented = true
            } label: {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 23, height: 23, alignment: .center)
            }
            .sheet(isPresented: $feedViewModel.createPostIsPresented) {
                PostCreateView()
            }
        }
    }
}

struct FeedCreatePostButton_Previews: PreviewProvider {
    static var previews: some View {
        FeedCreatePostButton()
    }
}
