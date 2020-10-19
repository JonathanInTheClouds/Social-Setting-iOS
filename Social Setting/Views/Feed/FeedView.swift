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
            ZStack {
                Color.tertiarySystemBackground
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack {
                        // TODO: - Add Functionality
                        ForEach(1...20, id: \.self) { value in
                            PostContentView()
                                .padding(.horizontal, 16)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            Separator()
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
                        Image(systemName: "rectangle.fill.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23, height: 23, alignment: .center)
                    })
                })
                .navigationBarTitleDisplayMode(.inline)
            }
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
