//
//  CustomTextField.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/22/20.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        
        var didBecomeFirstResponder = false
        
        var onCommit: () -> ()
        

        init(text: Binding<String>, onCommit: @escaping () -> ()) {
            _text = text
            self.onCommit = onCommit
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            onCommit()
            return true
        }
    }

    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false
    var isFirstResponder: Bool = false
    var onCommit: () -> ()
    

    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        return textField
    }

    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, onCommit: onCommit)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
        
    }
}

