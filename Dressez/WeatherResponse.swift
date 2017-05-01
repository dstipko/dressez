//
//  WeatherResponse.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherResponse: Mappable {
    
    var weatherCondition: WeatherCondition?
    var id: Int? {
        didSet {
            setWeatherCondition()
        }
    }
    var weatherName: String?
    var weatherDesc: String?
    var city: String?
    var country: String?
    var tempCurrent: Int?
    var tempMin: Int?
    var tempMax: Int?
    var pressure: Double?
    var humidity: Double?
    var windSpeed: Double?
        
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["weather.0.id"]
        weatherName <- map["weather.0.main"]
        weatherDesc <- map["weather.0.description"]
        city <- map["name"]
        country <- map["sys.country"]
        tempCurrent <- map["main.temp"]
        tempMin <- map["main.temp_min"]
        tempMax <- map["main.temp_max"]
        pressure <- map["main.pressure"]
        humidity <- map["main.humidity"]
        windSpeed <- map["wind.speed"]
    
    }
    
    private func setWeatherCondition() {
        guard let id = self.id else {
            self.weatherCondition = .sun
            return
        }
        
        if (id > WeatherCodeConstants.MinimumApiWeatherCode && id < WeatherCodeConstants.MaximumApiWeatherCode){
            switch(id){
            case WeatherCodeConstants.Thunderstorm..<WeatherCodeConstants.Drizzle:
                self.weatherCondition = .storm
            case WeatherCodeConstants.Drizzle..<WeatherCodeConstants.Rain:
                self.weatherCondition = .drizzle
            case WeatherCodeConstants.Rain..<WeatherCodeConstants.Snow:
                self.weatherCondition = .rain
            case WeatherCodeConstants.Snow..<WeatherCodeConstants.Atmosphere:
                self.weatherCondition = .snow
            case WeatherCodeConstants.Atmosphere..<WeatherCodeConstants.Clear:
                self.weatherCondition = .mist
            case WeatherCodeConstants.Clear:
                self.weatherCondition = .sun
            case WeatherCodeConstants.Clear..<WeatherCodeConstants.Clouds:
                self.weatherCondition = .cloud
            case WeatherCodeConstants.Extreme..<WeatherCodeConstants.Additional:
                self.weatherCondition = .storm
            case WeatherCodeConstants.Additional..<WeatherCodeConstants.MaximumApiWeatherCode:
                self.weatherCondition = .mist
            default:
                self.weatherCondition = .sun
            }
        } else {
            self.weatherCondition = .sun
        }
    }
    
    var location: String? {
        get {
            return city! + ", " + country!
        }
    }
}
