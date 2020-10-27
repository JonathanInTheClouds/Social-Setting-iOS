//
//  SSMarkDownView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/26/20.
//

import SwiftUI
import UIKit
import SwiftyMarkdown

struct SSMarkDownView: UIViewRepresentable {
    
    @Binding var markDownText: String
    
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        let md = SwiftyMarkdown(string: markDownText)
        label.attributedText = md.attributedString()
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
    }
    
}
