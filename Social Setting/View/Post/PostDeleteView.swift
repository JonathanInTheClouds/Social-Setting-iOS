//
//  PostDeleteView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/7/21.
//

import SwiftUI

struct PostDeleteView: View {
    var body: some View {
        DynamicBackground {
            Text("Post Has Been Deleted")
                .font(.largeTitle)
        }
    }
}

struct PostDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostDeleteView()
                .environment(\.colorScheme, .light)
            
            PostDeleteView()
                .environment(\.colorScheme, .dark)
        }
    }
}
