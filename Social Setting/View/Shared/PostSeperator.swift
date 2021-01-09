//
//  PostSeperator.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/5/21.
//

import SwiftUI

struct PostSeperator: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        (colorScheme == .light ? Color(.sRGB, red: 247/255, green: 247/255, blue: 247/255, opacity: 1) : Color(.sRGB, red: 25/255, green: 26/255, blue: 27/255, opacity: 1))
            .frame(height: 10)
    }
}

struct PostSeperator_Previews: PreviewProvider {
    static var previews: some View {
        PostSeperator()
    }
}
