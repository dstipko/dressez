//
//  Item Color.swift
//  Dressez
//
//  Created by Ivan Anic on 29/04/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

enum ItemColor : Int {
    case white
    case grey
    case black
    case red
    case green
    case blue
    case orange
    case yellow
    case purple
    
    static let allValues = [white, grey, black, red, green, blue, orange, yellow, purple]
    static let neutralValues = [white, grey, black]
    static let complementarySets = [[red, green],
                                    [blue, orange],
                                    [yellow, purple]]

    func description() -> String {
        switch self {
        case .white:
            return "White"
        case .grey:
            return "Grey"
        case .black:
            return "Black"
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        case .orange:
            return "Orange"
        case .yellow:
            return "Yellow"
        case .purple:
            return "Purple"
        }
    }
}
