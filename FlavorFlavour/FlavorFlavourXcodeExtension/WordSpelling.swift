//
//  WordSpelling.swift
//  FlavorFlavour
//
//  Created by Ellen Shapiro (Work) on 10/14/16.
//  Copyright © 2016 Designated Nerd Software. All rights reserved.
//

import FlavorKit
import Foundation

/// Delightfully hard-coded Brit-To-'Murican spellings.
enum WordSpelling: String {
    case
    flavor,
    behavior,
    color,
    center,
    program
    
    var USSpelling: String {
        return self.rawValue
    }
    
    var UKSpelling: String {
        switch self {
        case .flavor:
            return "flavour"
        case .behavior:
            return "behaviour"
        case .color:
            return "colour"
        case .center:
            return "centre"
        case .program:
            return "programme"
        }
    }
    
    func incorrectSpellingForMode(mode: FlavorMode) -> String {
        switch mode {
        case .UStoUK:
            return self.USSpelling
        case .UKtoUS:
            return self.UKSpelling
        }
    }
    
    func correctSpellingForMode(mode: FlavorMode) -> String {
        switch mode {
        case .UStoUK:
            return self.UKSpelling
        case .UKtoUS:
            return self.USSpelling
        }
    }
    
    //TODO: figure out a way to generate this automatically.
    static let allCases: [WordSpelling] = [
        .flavor,
        .behavior,
        .color,
        .center,
        .program
    ]
}
