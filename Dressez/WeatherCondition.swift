//
//  WeatherCondition.swift
//  Dressez
//
//  Created by Tvrtko Zadro on 01/05/2017.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

enum WeatherCondition : Int {
    case storm
    case drizzle
    case rain
    case snow
    case mist
    case sun
    case cloud
    
    static let allValues = [storm, drizzle, rain, snow, mist, sun, cloud]
    
    func description() -> String {
        switch self {
        case .storm:
            return "Storm"
        case .drizzle:
            return "Drizzle"
        case .rain:
            return "Rain"
        case .snow:
            return "Snow"
        case .mist:
            return "Mist"
        case .sun:
            return "Sun"
        case .cloud:
            return "Cloud"
        }
    }
    
    func getIcon() -> UIImage {
        switch self {
        case .storm:
            return #imageLiteral(resourceName: "storm")
        case .drizzle:
            return #imageLiteral(resourceName: "drizzle")
        case .rain:
            return #imageLiteral(resourceName: "rain")
        case .snow:
            return #imageLiteral(resourceName: "snow")
        case .mist:
            return #imageLiteral(resourceName: "mist")
        case .sun:
            return #imageLiteral(resourceName: "sun")
        case .cloud:
            return #imageLiteral(resourceName: "cloud")
        }
    }
    
    func getAppropriateItemTypeIds() -> [Int] {
        var enumArray: [ItemType]
        
        switch self {
        case .storm:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .heavyJacket, .coat, .leatherShoes, .boots]
        case .drizzle:
            enumArray = [.trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .coat, .leatherShoes, .boots]
        case .rain:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .lightJacket, .heavyJacket, .coat, .leatherShoes, .boots]
        case .snow:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .lightJacket, .heavyJacket, .coat, .leatherShoes, .boots]
        case .mist:
            enumArray = [.trousers, .tracksuit, .tshirt, .shirt, .hoodie, .sweater, .lightJacket, .coat, .leatherShoes, .boots]
        case .sun:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .canvasShoes, .leatherShoes]
        case .cloud:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .canvasShoes, .leatherShoes]
        }
        
        return enumArray.map({
            (enumValue: ItemType) -> Int in
            return enumValue.rawValue
        })
    }
}
