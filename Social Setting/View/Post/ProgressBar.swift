//
//  ProgressBar.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/19/21.
//

import SwiftUI

struct ProgressBar: View {
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geomtry in
            Rectangle().frame(width: min(CGFloat(self.value) * geomtry.size.width, geomtry.size.width), height: geomtry.size.height)
                .foregroundColor(Color.baseColor)
                .animation(.spring())
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: .constant(50))
    }
}
