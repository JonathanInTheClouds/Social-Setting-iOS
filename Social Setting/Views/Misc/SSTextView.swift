//
//  SSTextView.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/16/20.
//

import SwiftUI
import iTextField

struct SSTextView: View {
    
    @Binding var field: String
    
    @Binding var fieldEditing: Bool
    
    var placeholder: String
    
    var returnType: UIReturnKeyType = .next
    
    var keyboardType: UIKeyboardType = .default
    
    var isSecure: Bool = false
    
    var autoCorrection: Bool = false
    
    var autoCap: Bool = true
    
    var enterAction: (() -> ())?
    
    
    var body: some View {
        iTextField(placeholder, text: $field, isEditing: $fieldEditing)
            .onReturn(perform: enterAction)
            .keyboardType(keyboardType)
            .returnKeyType(returnType)
            .isSecure(isSecure)
            .disableAutocorrection(autoCorrection)
            .disableAutocorrection(autoCap)
            .frame(height: 21, alignment: .center)
            .padding()
            .background(Color.gray19)
            .cornerRadius(6)
            
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
