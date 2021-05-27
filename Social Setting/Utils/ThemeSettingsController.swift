//
//  ThemeSettingsController.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 5/12/21.
//

import Combine
import SwiftUI

class ThemeSettingsController: ObservableObject {
    
    @Published var mainTint: Color = .orange {
        didSet {
            if let encoded = try? encoder.encode(mainTint) {
                defaults.set(encoded, forKey: "Tint")
            }
        }
    }
    
    private let defaults = UserDefaults.standard
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    init() {
        if let data = defaults.data(forKey: "Tint") {
            if let tint = try? decoder.decode(Color.self, from: data) {
                mainTint = tint
            }
        }
    }
    
}

