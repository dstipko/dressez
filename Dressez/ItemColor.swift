//
//  Item Color.swift
//  Dressez
//
//  Created by Ivan Anic on 29/04/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

enum ItemColor : Int {
    case blue
    case white
    case red
    case pink
    case orange
    case purple
    case green
    case gold
    case gray
    
    static let allValues = [blue, red, white, pink, orange, purple, green, gold, gray]

    func description() -> String {
        switch self {
        case .blue:
            return "Blue"
        case .white:
            return "White"
        case .red:
            return "Red"
        case .pink:
            return "Pink"
        case .orange:
            return "Orange"
        case .purple:
            return "Purple"
        case .green:
            return "Green"
        case .gold:
            return "Gold"
        case .gray:
            return "Gray"                                            
        }
    }
}
