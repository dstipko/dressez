//
//  ItemType.swift
//  Dressez
//
//  Created by Ivan Anic on 29/04/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

enum ItemType : Int {
    case shorts
    case trousers
    case tracksuit
    case shirt
    case tshirt
    case hoodie
    case sweater
    case lightJacket
    case heavyJacket
    case coat
    case canvasShoes
    case leatherShoes
    case boots

    static let allValues = [shorts, trousers, tracksuit, shirt, tshirt, hoodie,
                            sweater, lightJacket, heavyJacket, coat,
                            canvasShoes, leatherShoes, boots]
    
    func description() -> String {
        switch self {
        case .shorts:
            return "Shorts"
        case .trousers:
            return "Trousers"
        case .tracksuit:
            return "Tracksuit"
        case .shirt:
            return "Shirt"
        case .tshirt:
            return "T-Shirt"
        case .hoodie:
            return "Hoodie"
        case .sweater:
            return "Sweater"
        case .lightJacket:
            return "Light jacket"
        case .heavyJacket:
            return "Heavy jacket"
        case .coat:
            return "Coat"
        case .canvasShoes:
            return "Canvas shoes"
        case .leatherShoes:
            return "Leather shoes"
        case .boots:
            return "Boots"
        }
    }
    
    func getCategory() -> ItemCategory {
        switch self {
        case .shorts, .trousers, .tracksuit:
            return .legs
        case .shirt, .tshirt, .hoodie, .sweater:
            return .torsoInner
        case .lightJacket, .heavyJacket, .coat:
            return .torsoOuter
        case .canvasShoes, .leatherShoes, .boots:
            return .feet
        }
    }
}
