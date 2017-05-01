//
//  ItemCategory.swift
//  Dressez
//
//  Created by Tvrtko Zadro on 01/05/2017.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

enum ItemCategory : Int {
    case torsoInner
    case torsoOutter
    case legs
    case feet
    
    static let allValues = [torsoInner, torsoOutter, legs, feet]
    
    func description() -> String {
        switch self {
        case .torsoInner:
            return "Torso"
        case .torsoOutter:
            return "Torso outter"
        case .legs:
            return "Legs"
        case .feet:
            return "Feet"
        }
    }
}
