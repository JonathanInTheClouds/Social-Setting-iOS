//
//  PostView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/7/21.
//

import SwiftUI

struct PostView: View {
    
    @State var bookmarked = false
    
    var body: some View {
        VStack {
            HStack {
                Image("User")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .center) {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Joshua Lawrance")
                                .foregroundColor(Color.labelPrimary)
                        })
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.accentColor)
                    }
                    
                    HStack {
                        Text("@joshua_l")
                        Text("·")
                        Text("2h ago")
                    }
                    .foregroundColor(Color.labelSecondary)
                }
                
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color.labelSecondary)
                        .padding(.all, 5)
                })
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            Color.labelTertiary
                .frame(height: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea(.all, edges: .horizontal)
            
            HStack(spacing: 29.5) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("Like")
                    }
                })
                .foregroundColor(.accentColor)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Text("Reply")
                    }
                })
                .foregroundColor(Color.labelSecondary)
                
                Spacer()
                
                Button(action: {
                    bookmarked.toggle()
                }, label: {
                    Image(systemName: "bookmark")
                })
                .foregroundColor(!bookmarked ? Color.labelSecondary : .accentColor)
                
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            
            HStack {
                Text("420")
                    .bold()
                Text("likes")
                Text("·")
                Text("16")
                    .bold()
                Text("comments")
                Spacer()
            }
            .padding(.horizontal, 16)
            
            Text("I recently understood the words of my friend Jacob West about music.")
                .padding(.vertical, 1)
        }
        .padding(.bottom)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
