//
//  TintColorView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/12/21.
//

import SwiftUI

struct TintColorView: View {
    
    @EnvironmentObject var themeController: ThemeSettingsController
    
    @State var selectedColor: Color = .clear
    
    let colors: [Color] = [
        .blue,
        .indigo,
        .purple,
        .teal,
        .green,
        .yellow,
        .orange,
        .pink,
        .red
    ]
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Tint") {
            if let tint = try? JSONDecoder().decode(Color.self, from: data) {
                selectedColor = tint
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            List {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        selectedColor = color
                        themeController.mainTint = selectedColor
                    }, label: {
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30, alignment: .center)
                                .padding(.trailing, 5)
                            Text(color.name())
                                .foregroundColor(.labelPrimary)
                            Spacer()
                            if color == themeController.mainTint  {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        .foregroundColor(color)
                    })
                    .padding(.vertical, 5)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Appearance")
        }
    }
}

struct TintColorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TintColorView()
                .preferredColorScheme(.light)
            
            TintColorView()
                .preferredColorScheme(.dark)
        }
    }
}
