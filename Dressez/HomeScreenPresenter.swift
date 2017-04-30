//
//  HomeScreenPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenPresenter: BasePresenter {
 
    required init() { }
    
    weak var baseViewController: BaseViewController!
    weak var viewController: HomeScreenController! {
        return baseViewController as! HomeScreenController
    }
    
    func setup() {
        viewController.navigationItem.title = "Dressez"
    }
    
    func updateView(with : WeatherResponse){
        viewController.imageWeatherIcon.image = UIImage(named: "rain.png")
        
        viewController.labelTemperature.text = String(describing: with.tempCurrent!) + "°C"
        viewController.labelWeatherDesc.text = with.weatherDesc
        viewController.labelCityName.text = with.location
        viewController.labelTemperatureHiLo.text =
            "H " + String(describing: with.tempMax!) + "°" +
            " L " + String(describing: with.tempMin!) + "°"
        viewController.labelHumidity.text = "Humidity: " + String(describing: with.tempCurrent!) + "%"
        viewController.labelWind.text = "Wind: " + String(describing: with.windSpeed!) + " km/h"
        viewController.labelPressure.text = "Pressure: " + String(describing: with.pressure!) + " hPa"
    }
}
