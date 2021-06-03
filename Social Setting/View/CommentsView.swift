//
//  CommentsView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/22/21.
//

import SwiftUI

struct CommentsView: View {
    
    @ObservedObject var viewModel: CommentViewModel
    
    @Binding var post: PostModel
    
    @State var text = ""
    
    var body: some View {
        ZStack {
            Color.dynamicBackground.ignoresSafeArea(edges: .all)
            ScrollView {
                LazyVStack {
                    CommentHeadView(post: $post)
                        .padding(.top, 32)
                    Color.separatorOpaque
                        .frame(height: 1, alignment: .center)
                        .opacity(0.5)
                        .padding(.top, 16)
                    
                    ForEach(viewModel.commentsArray, id: \.self) { comment in
                        CommentItem(comment: comment)
                            .padding(.top, 10)
                    }
                }
                .padding(.bottom, 100)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("15 Comments")
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CommentsView(viewModel: CommentViewModel(), post: .constant(posts[0]))
                    .preferredColorScheme(.light)
            }
            
            NavigationView {
                CommentsView(viewModel: CommentViewModel(), post: .constant(posts[0]))
                    .preferredColorScheme(.dark)
            }
        }
    }
}


struct StickyHeader<Content: View>: View {
    
    var minHeight: CGFloat
    var content: Content
    
    init(minHeight: CGFloat = 200, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            if(geo.frame(in: .global).minY <= 0) {
                content
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            } else {
                content
                    .offset(y: -geo.frame(in: .global).minY)
                    .frame(width: geo.size.width, height: geo.size.height + geo.frame(in: .global).minY)
            }
        }.frame(minHeight: minHeight)
    }
}

import UIKit

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?
    
    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator
        
        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        if nil != onDone {
            textField.returnKeyType = .done
        }
        
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }
    
    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?
        
        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }
        
        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }
    
}

struct MultilineTextField: View {
    
    private var placeholder: String
    private var onCommit: (() -> Void)?
    
    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }
    
    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false
    
    init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }
    
    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $dynamicHeight, onDone: onCommit)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .background(placeholderView, alignment: .topLeading)
    }
    
    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}

#if DEBUG
struct MultilineTextField_Previews: PreviewProvider {
    static var test:String = ""//some very very very long description string to be initially wider than screen"
    static var testBinding = Binding<String>(get: { test }, set: {
                                                //        print("New value: \($0)")
                                                test = $0 } )
    
    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Description:")
            MultilineTextField("Enter some text here", text: testBinding, onCommit: {
                print("Final text: \(test)")
            })
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
            Text("Something static here...")
            Spacer()
        }
        .padding()
    }
}
#endif

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CommentHeadView: View {
    
    @State var isPresented = false
    
    @Binding var post: PostModel
    
    var body: some View {
        LazyVStack {
            HStack(alignment: .top, spacing: 10) {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Image("User")
                            .resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                            .cornerRadius(32/2)
                    })
                    .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {}, label: {
                        Text("@\(post.user.username)   ").bold() + Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor lacinia aliquam. Quisque semper gravida tellus vel accumsan. Sed nec risus.")
                    })
                    .foregroundColor(Color.labelPrimary)
                    
                    HStack {
                        Text("\(post.timeAgo)")
                            .foregroundColor(Color.labelSecondary)
                            .font(.subheadline)
                        Button(action: {
                            post.liked.toggle()
                        }, label: {
                            Text("Reply")
                                .bold()
                        })
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $isPresented, content: {
                ReplyView(opened: $isPresented, name: post.user.name, username: post.user.username, timeAgo: post.timeAgo, text: post.text) {
                    
                }
            })
        }
    }
}


struct CommentItem: View {
    
    @State var isPresented = false
    
    @State var expanded = false
    
    let comment: CommentModel
    
    var body: some View {
        LazyVStack {
            HStack(alignment: .top, spacing: 10) {
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Image("User")
                            .resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                            .cornerRadius(32/2)
                    })
                    .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {
                        withAnimation(.spring()) {
                            expanded.toggle()
                        }
                    }, label: {
                        Text("@\(comment.user.username) ").bold() + Text(comment.text)
                    })
                    .foregroundColor(Color.labelPrimary)
                    
                    HStack {
                        Text(comment.timeAgo)
                            .foregroundColor(Color.labelSecondary)
                            .font(.subheadline)
                        Button(action: {
                        }, label: {
                            Text("Reply")
                                .bold()
                                .foregroundColor(Color.labelSecondary)
                        })
                        Spacer()
                    }
                }
                
                
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $isPresented, content: {
                ReplyView(opened: $isPresented, name: comment.user.name, username: comment.user.username, timeAgo: comment.timeAgo, text: comment.text) {
                    
                }
            })
            
            if expanded {
                ForEach((1...Int.random(in: 1...4)), id: \.self) { _ in
                    CommentItem(comment: commentsArray[0])
                        .padding(.leading, 50)
                }
            }
        }
    }
}
