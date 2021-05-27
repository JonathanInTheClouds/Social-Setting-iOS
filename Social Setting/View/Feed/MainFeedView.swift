//
//  MainFeedView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/10/21.
//

import SwiftUI

struct MainFeedView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.dynamicBackground.ignoresSafeArea(edges: .all)
                    .navigationTitle("Today")
                ScrollView {
                    LazyVStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                StoryItemButton(addingItem: true)
                                
                                StoryItemButton(username: "jacob_w")
                                
                                StoryItemButton(username: "mettaworldj")
                                
                                StoryItemButton(username: "jon.d")
                                
                                StoryItemButton(username: "u2luve")
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 5)
                        }
                        ForEach(1...200, id: \.self) { i in
                            Color.separatorOpaque
                                .frame(height: 1, alignment: .center)
                                .opacity(0.5)
                                .padding(.top, 16)
                                .id(i)
                            
                            PostView()
                        }
                    }
                    
                }
                .fixFlickering()
            }
        }
    }
}

struct MainFeedView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainFeedView().preferredColorScheme(.light)
            
            MainFeedView().preferredColorScheme(.dark)
        }
    }
}

extension ScrollView {
    
    public func fixFlickering() -> some View {
        
        return self.fixFlickering { (scrollView) in
            
            return scrollView
        }
    }
    
    public func fixFlickering<T: View>(@ViewBuilder configurator: @escaping (ScrollView<AnyView>) -> T) -> some View {
        
        GeometryReader { geometryWithSafeArea in
            GeometryReader { geometry in
                configurator(
                ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
                    AnyView(
                    VStack {
                        self.content
                    }
                    .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
                    .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
                    .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
                    .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing)
                    )
                }
                )
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
