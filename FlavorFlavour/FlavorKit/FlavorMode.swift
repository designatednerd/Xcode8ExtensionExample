//
//  FlavorMode.swift
//  FlavorFlavour
//
//  Created by Ellen Shapiro (Work) on 10/14/16.
//  Copyright © 2016 Designated Nerd Software. All rights reserved.
//

import Foundation

public enum FlavorMode: String {
    case
    UStoUK,
    UKtoUS
    
    public var emojified: String {
        switch self {
        case .UStoUK:
            return "🇬🇧 ⬅️ 🇺🇸"
        case .UKtoUS:
            return "🇬🇧 ➡️ 🇺🇸"
        }
    }
}
    
