//
//  MDPreview.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/26/20.
//

import SwiftUI

struct MDPreview: View {
    
    @Binding var mdText: String
    
    var body: some View {
        ScrollView {
            SSMarkDownView(markDownText: $mdText)
        }
    }
}

struct MDPreview_Previews: PreviewProvider {
    
    static  var mdText: String = ""
    
    static var previews: some View {
        MDPreview(mdText: .constant("Hello"))
    }
}
