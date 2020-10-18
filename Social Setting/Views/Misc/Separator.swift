//
//  Separator.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/17/20.
//

import SwiftUI

struct Separator: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if colorScheme == .light {
            Color(.sRGB, red: 247/255, green: 247/255, blue: 247/255, opacity: 1)
        } else {
            Color(.sRGB, red: 25/255, green: 26/255, blue: 27/255, opacity: 1)
        }
    }
}

struct Separator_Previews: PreviewProvider {
    static var previews: some View {
        Separator()
    }
}
