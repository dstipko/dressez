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
        viewController.imageWeatherIcon.image = with.weatherCondition?.getIcon()
        
        viewController.labelTemperature.text = String(describing: with.tempCurrent!) + "°C"
        viewController.labelWeatherDesc.text = with.weatherDesc
        viewController.labelCityName.text = with.location
        viewController.labelTemperatureHiLo.text =
            "H " + String(describing: with.tempMax!) + "°" +
            " L " + String(describing: with.tempMin!) + "°"
        viewController.labelHumidity.text = "Humidity: " + String(describing: with.tempCurrent!) + "%"
        viewController.labelWind.text = "Wind: " + String(describing: with.windSpeed!) + " km/h"
        viewController.labelPressure.text = "Pressure: " + String(describing: with.pressure!) + " hPa"
        
        //TODO: REMOVE CODE BELOW
        guard let temp = with.tempCurrent else {
            return
        }
        
        var enumArray: [ItemType]
        
        switch temp {
        case -100..<5:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .heavyJacket, .coat, .leatherShoes, .boots]
        case 5..<15:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .lightJacket, .heavyJacket, .coat, .canvasShoes, .leatherShoes, .boots]
        case 15..<25:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .coat, .canvasShoes, .leatherShoes]
        case 25..<100:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .canvasShoes, .leatherShoes]
        default:
            enumArray = []
        }
        
        let temperatureItemTypes = enumArray.map({
            (enumValue: ItemType) -> Int in
            return enumValue.rawValue
        })
        
        let items = persistanceService.fetchClothingItems(weatherConditionItemTypes: (with.weatherCondition?.getAppropriateItemTypeIds())!, temperatureItemTypes: temperatureItemTypes)
        for item in items {
            print(item.name)
        }
        print(with.weatherCondition?.description() ?? "no value")
    }
    
    func assignBackground() {
        guard let backgroundImage = UIImage(named: "background") else {
            viewController.view.backgroundColor = ColorConstants.green
            return
        }
        
        UIGraphicsBeginImageContext(viewController.view.frame.size)
        backgroundImage.draw(in: viewController.view.bounds)
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
