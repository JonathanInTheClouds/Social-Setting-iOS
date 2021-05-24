//
//  ProfileImage.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/23/21.
//

import SwiftUI

struct ProfileImage: View {
    
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.labelQuarternary)
            
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: size - 68, height: size - 68, alignment: .center)
                .clipShape(Circle())
                .foregroundColor(Color.labelTertiary)
        }
        .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(size: 100)
    }
}
