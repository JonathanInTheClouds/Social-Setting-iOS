//
//  ProfileImage.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/18/20.
//

import SwiftUI

struct ProfileImage<V: View>: View {
    
    @State var buttonSize: CGFloat = 70
    
    @State var imageSize: CGFloat = 28
    
    var destination: V
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            ZStack {
                Color.gray19
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize, height: imageSize, alignment: .center)
                    .foregroundColor(Color.gray79)
            }.frame(width: buttonSize, height: buttonSize, alignment: .center)
        }).clipShape(Circle())
    }
}


struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(destination: Text("Hello World"))
    }
}
