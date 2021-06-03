//
//  Theme.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/28/21.
//

import SwiftUI

extension Color {
    public static var labelPrimary: Color {
        return Color("Label Primary")
    }
    
    public static var labelSecondary: Color {
        return Color("Label Secondary")
    }
    
    public static var labelTertiary: Color {
        return Color("Label Tertiary")
    }
    
    public static var labelQuarternary: Color {
        return Color("Label Quarternary")
    }
    
    public static var fillPrimary: Color {
        return Color("Fill Primary")
    }
    
    public static var fillSecondary: Color {
        return Color("Fill Secondary")
    }
    
    public static var fillTertiary: Color {
        return Color("Fill Tertiary")
    }
    
    public static var fillQuarternary: Color {
        return Color("Fill Quarternary")
    }
    
    public static var separator: Color {
        return Color("Separator")
    }
    
    public static var separatorOpaque: Color {
        return Color("Separator Opaque")
    }
    
    public static var dynamicBackground: Color {
        return Color("Dynamic Background")
    }
    
    public static var systemGray: Color {
        return Color("SystemGray")
    }
    
    public static var indigo: Color {
        return Color("Indigo")
    }
    
    public static var teal: Color {
        return Color("Teal")
    }
    
    public static var offWhite: Color {
        return Color("Off White")
    }
}

extension Color {
    func name() -> String {
        var name = ""
        
        switch self {
        case .blue:
            name = "Blue"
        case .indigo:
            name = "Indigo"
        case .purple:
            name = "Purple"
        case .teal :
            name = "Teal"
        case .green:
            name = "Green"
        case .yellow:
            name = "Yellow"
        case .orange:
            name = "Orange"
        case .pink:
            name = "Pink"
        case .red:
            name = "Red"
        default:
            name = ""
        }
        
        return name
    }
}


#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

fileprivate extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}
