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
    
    static func setAppropriateWeatherIcon(weatherID : Int) -> UIImage {
        if (weatherID > WeatherCodeConstants.MinimumApiWeatherCode && weatherID < WeatherCodeConstants.MaximumApiWeatherCode){
            switch(weatherID){
                case WeatherCodeConstants.Thunderstorm..<WeatherCodeConstants.Drizzle:
                    return #imageLiteral(resourceName: "storm")
                case WeatherCodeConstants.Drizzle..<WeatherCodeConstants.Rain:
                    return #imageLiteral(resourceName: "drizzle")
                case WeatherCodeConstants.Rain..<WeatherCodeConstants.Snow:
                    return #imageLiteral(resourceName: "rain")
                case WeatherCodeConstants.Snow..<WeatherCodeConstants.Atmosphere:
                    return #imageLiteral(resourceName: "snow")
                case WeatherCodeConstants.Atmosphere..<WeatherCodeConstants.Clear:
                    return #imageLiteral(resourceName: "mist")
                case WeatherCodeConstants.Clear:
                    return #imageLiteral(resourceName: "sun")
                case WeatherCodeConstants.Clear..<WeatherCodeConstants.Clouds:
                    return #imageLiteral(resourceName: "cloud")
                case WeatherCodeConstants.Extreme..<WeatherCodeConstants.Additional:
                    return #imageLiteral(resourceName: "storm")
                case WeatherCodeConstants.Additional..<WeatherCodeConstants.MaximumApiWeatherCode:
                    return #imageLiteral(resourceName: "mist")
                default:
                    return #imageLiteral(resourceName: "sun")
            }
        } else {
            return #imageLiteral(resourceName: "sun")
        }
    }
}
