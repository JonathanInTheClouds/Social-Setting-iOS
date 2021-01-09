//
//  StandardInputView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import SwiftUI
import iTextField

struct StandardInputView: View {
    
    @Binding var field: String
    
    @Binding var fieldEditing: Bool
    
    var placeholder: String
    
    var returnType: UIReturnKeyType = .next
    
    var keyboardType: UIKeyboardType = .default
    
    var isSecure: Bool = false
    
    var autoCorrection: Bool = false
    
    var autoCap: Bool = false
    
    var enterAction: (() -> ())?
    
    var body: some View {
        
        iTextField(placeholder, text: $field, isEditing: $fieldEditing)
            .onReturn(perform: enterAction)
            .keyboardType(keyboardType)
            .returnKeyType(returnType)
            .isSecure(isSecure)
            .disableAutocorrection(autoCorrection)
            .disableAutocorrection(autoCap)
            .autocapitalization(.none)
            .frame(height: 21, alignment: .center)
            .padding()
            .background(Color.gray19)
            .cornerRadius(6)
        
    }
}

struct StandardInputView_Previews: PreviewProvider {
    static var previews: some View {
        StandardInputView(field: .constant(""), fieldEditing: .constant(true), placeholder: "Username")
    }
}
