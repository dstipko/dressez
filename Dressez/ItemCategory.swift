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
    case torsoOuter
    case legs
    case feet
    
    static let allValues = [torsoInner, torsoOuter, legs, feet]
    static let crucialCategories = [torsoInner, legs, feet]
    
    func description() -> String {
        switch self {
        case .torsoInner:
            return "Torso"
        case .torsoOuter:
            return "Torso outer"
        case .legs:
            return "Legs"
        case .feet:
            return "Feet"
        }
    }
}
