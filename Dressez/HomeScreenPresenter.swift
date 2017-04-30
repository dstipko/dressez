//
//  HomeScreenPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class HomeScreenPresenter: BasePresenter {
    
    var navigationService: NavigationService!
    var persistanceService: PersistanceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: HomeScreenController! {
        return baseViewController as! HomeScreenController
    }
    
    required init() { }
    
    func setup() {
        viewController.navigationItem.title = "Dressez"
    }
    
    func updateView(with : WeatherResponse) {
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
    
    func assignbackground() {
        UIGraphicsBeginImageContext(viewController.view.frame.size)
        UIImage(named: "background")?.draw(in: viewController.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        viewController.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func addRoundedBorders() {
        viewController.reccomendationsView.layer.cornerRadius = NumberConstants.cornerRadius
        viewController.reccomendationsView.layer.shadowColor = UIColor.black.cgColor
        viewController.reccomendationsView.layer.shadowOpacity = 0.5
        viewController.reccomendationsView.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewController.reccomendationsView.layer.shadowRadius = 05
        viewController.reccomendationsView.layer.shadowPath = UIBezierPath(rect: viewController.reccomendationsView.bounds).cgPath
        viewController.reccomendationsView.layer.shouldRasterize = true
    }
    
    func fetchWeather() -> Observable<WeatherResponse> {
        return networking.fetchWeather()
    }
}
