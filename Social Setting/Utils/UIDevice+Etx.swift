//
//  UIDevice+Etx.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 11/1/20.
//

import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}
