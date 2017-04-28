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
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["weather.0.id"]
    }
}
