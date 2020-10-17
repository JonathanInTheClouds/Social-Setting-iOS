//
//  SSTextView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI
import TextView

struct SSTextView: View {
    
    @Binding var field: String
    
    @Binding var fieldEditing: Bool
    
    var placeholder: String
    
    var returnType: UIReturnKeyType = .next
    
    var keyboardType: UIKeyboardType = .default
    
    var enterAction: (() -> ())?
    
    
    var body: some View {
        TextView(text: $field, isEditing: $fieldEditing, placeholder: placeholder,
                 textHorizontalPadding: -4, textVerticalPadding: 0,
                 placeholderHorizontalPadding: -1, placeholderVerticalPadding: 1, returnType: returnType, shouldChange: { _, character -> Bool in
                    let isEntered = character == "\n"
                    if isEntered, let enterAction = enterAction {
                        enterAction()
                    }
                    return isEntered ? false : true
                 })
            .frame(height: 21, alignment: .center)
            .padding()
            .background(Color.gray19)
            .cornerRadius(6)
            .keyboardType(keyboardType)
    }
}

struct SSTextView_Previews: PreviewProvider {
    
    @State static var field = ""
    
    @State static var fieldEditing = true
    
    
    static var previews: some View {
        SSTextView(field: $field, fieldEditing: $fieldEditing, placeholder: "Email", returnType: .next, keyboardType: .default, enterAction: {
            
        })
    }
}
