//
//  SettingsView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/11/21.
//

import SwiftUI

struct SettingsView: View {
    
    let data = Array(1...50).map { "Item \($0)" }
    
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.dynamicBackground.ignoresSafeArea(edges: .all)
                    .navigationTitle("Settings")
                ScrollView {
                    LazyVGrid(columns: layout, spacing: 10, content: {
                        NavigationLink(
                            destination: TintColorView(),
                            label: {
                                ZStack {
                                    Color.fillTertiary
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Image(systemName: "drop.fill")
                                                .padding(.leading, 5)
                                                .foregroundColor(.accentColor)
                                            Spacer()
                                        }
                                        Text("Appearance")
                                            .foregroundColor(Color.labelPrimary)
                                    }.padding([.leading, .bottom, .top])
                                }.cornerRadius(16)
                            })
                        
                        NavigationLink(
                            destination: Text("Destination"),
                            label: {
                                ZStack {
                                    Color.fillTertiary
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Image(systemName: "person.2.fill")
                                                .padding(.leading, 5)
                                                .foregroundColor(.accentColor)
                                            Spacer()
                                        }
                                        Text("Friends")
                                            .foregroundColor(Color.labelPrimary)
                                    }.padding([.leading, .bottom, .top])
                                }.cornerRadius(16)
                            })
                    })
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
                .fixFlickering()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
                .preferredColorScheme(.light)
            
            SettingsView()
                .preferredColorScheme(.dark)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
