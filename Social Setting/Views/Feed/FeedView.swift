//
//  Feed.swift
//  Social Setting
//
//  Created by Mettaworldj on 10/14/20.
//

import SwiftUI

struct FeedView: View {
    
    @State private var searchText : String = ""
    @ObservedObject var searchBar: SearchBar = SearchBar()
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(1...10, id: \.self) { value in
                        PostContentView()
                            .padding(.horizontal, 16)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        if colorScheme == .light {
                            Color(.sRGB, red: 247/255, green: 247/255, blue: 247/255, opacity: 1)
                        } else {
                            Color(.sRGB, red: 25/255, green: 26/255, blue: 27/255, opacity: 1)
                        }
                    }
                }
                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            .add(self.searchBar)
            .navigationBarItems(leading: HStack {
                Image("large-logo")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                Text("Social Setting")
                    .foregroundColor(Color.gray99)
            }, trailing: HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "shippingbox.fill")
                })
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func updateText() {
        
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedView()
                .environment(\.colorScheme, .light)
            
            FeedView()
                .environment(\.colorScheme, .dark)
        }
    }
}
