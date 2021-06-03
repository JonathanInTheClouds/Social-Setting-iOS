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
    
    let name: String
    
    let username: String
    
    let timeAgo: String
    
    let text: String
    
    let action: () -> ()
    
    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $reply, textStyle: $textStyle, firstResponder: $isActive)
                    .navigationBarTitleDisplayMode(.inline)
                    .padding()
                
                VStack(alignment: .leading) {
                    PostViewHeader(name: name, username: username, timeAgo: timeAgo)
                    Text(text)
                        .padding(.horizontal, 16)
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
                    Button(action: action, label: {
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
            ReplyView(opened: .constant(false), name: posts[0].user.name, username: posts[0].user.username, timeAgo: posts[0].timeAgo, text: posts[0].text, action: {
                
            })
                .preferredColorScheme(.light)
            
            ReplyView(opened: .constant(false), name: posts[0].user.name, username: posts[0].user.username, timeAgo: posts[0].timeAgo, text: posts[0].text, action: {
                
            })
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
