//
//  ReplyView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/22/21.
//

import SwiftUI

struct ReplyView: View {
    
    @ObservedObject private var themeController = ThemeSettingsController()
    
    @State var textStyle: UIFont.TextStyle = UIFont.TextStyle.body
    
    @State var reply = ""
    
    @State var isActive = true
    
    @Binding var opened: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $reply, textStyle: $textStyle, firstResponder: $isActive)
                    .navigationBarTitleDisplayMode(.inline)
                    .padding()
                
                VStack {
                    PostViewHeader()
                    Text("I recently understood the words of my friend Jacond West about music")
                }
                .padding(.bottom, 16)
            }
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                    Button(action: {
                        opened = false
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.primaryAction) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Reply")
                    })
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.principal) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        VStack {
                            Text("New Comment")
                                .foregroundColor(Color.labelPrimary)
                                .bold()
                            Text("mettaworldj")
                                .font(.caption2)
                                .foregroundColor(Color.labelSecondary)
                        }
                    })
                }
        })
        }
        .accentColor(themeController.mainTint)
    }
}

struct ReplyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReplyView(opened: .constant(false))
                .preferredColorScheme(.light)
            
            ReplyView(opened: .constant(false))
                .preferredColorScheme(.dark)
        }
    }
}


struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
    @Binding var firstResponder: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        
        if firstResponder {
            textView.becomeFirstResponder()
        } else {
            textView.resignFirstResponder()
        }
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        
        init(_ text: Binding<String>) {
            self.text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
}
