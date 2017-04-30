//
//  IconUtil.swift
//  Dressez
//
//  Created by Ivan Anic on 30/04/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class IconUtil {
    
    static let MinimumApiWeatherCode = 200
    static let MaximumApiWeatherCode = 999
    static let Thunderstorm = 200
    static let Drizzle = 300
    static let Rain = 500
    static let Snow = 600
    static let Atmosphere = 700
    static let Clear = 800
    static let Clouds = 810
    static let Extreme = 900
    static let Additional = 910
    
    static func setAppropriateWeatherIcon(weatherID : Int) -> UIImage {
        if (weatherID > IconUtil.MinimumApiWeatherCode && weatherID < IconUtil.MaximumApiWeatherCode){
            switch(weatherID){
                case IconUtil.Thunderstorm..<IconUtil.Drizzle:
                    return #imageLiteral(resourceName: "storm")
                case IconUtil.Drizzle..<IconUtil.Rain:
                    return #imageLiteral(resourceName: "drizzle")
                case IconUtil.Rain..<IconUtil.Snow:
                    return #imageLiteral(resourceName: "rain")
                case IconUtil.Snow..<IconUtil.Atmosphere:
                    return #imageLiteral(resourceName: "snow")
                case IconUtil.Atmosphere..<IconUtil.Clear:
                    return #imageLiteral(resourceName: "mist")
                case IconUtil.Clear:
                    return #imageLiteral(resourceName: "sun")
                case IconUtil.Clear..<IconUtil.Clouds:
                    return #imageLiteral(resourceName: "cloud")
                case IconUtil.Extreme..<IconUtil.Additional:
                    return #imageLiteral(resourceName: "storm")
                case IconUtil.Additional..<IconUtil.MaximumApiWeatherCode:
                    return #imageLiteral(resourceName: "mist")
                default:
                    return #imageLiteral(resourceName: "sun")
            }
        } else {
            return #imageLiteral(resourceName: "sun")
        }
    }
}
