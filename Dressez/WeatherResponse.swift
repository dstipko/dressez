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
 
    var id: Int?
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
    
    var location: String? {
        get {
            return city! + ", " + country!
        }
    }
}
