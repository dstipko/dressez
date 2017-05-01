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
    
    private let spacing : CGFloat = 28
    private let cellHeight : CGFloat = 100
    
    var navigationService: NavigationService!
    var persistanceService: PersistanceService!
    var networking: NetworkingService!
    
    private var outfitService = OutfitService()
    private var weatherInfo: WeatherResponse?
    var outfit: [ClothingItem]?

    weak var baseViewController: BaseViewController!
    weak var viewController: HomeScreenController! {
        return baseViewController as! HomeScreenController
    }
    
    required init() {}
    
    func setup() {
        viewController.navigationItem.title = "Dressez"
    }
    
    func updateView(with weatherResponse: WeatherResponse) {
        weatherInfo = weatherResponse
        
        updateWeatherPreview()
        updateOutfitPreview()
    }
    
    private func updateWeatherPreview() {
        guard let weatherInfo = self.weatherInfo else {
            return
        }
        
        viewController.imageWeatherIcon.image = weatherInfo.weatherCondition?.getIcon()
        
        viewController.labelTemperature.text = String(describing: weatherInfo.tempCurrent!) + "°C"
        viewController.labelWeatherDesc.text = weatherInfo.weatherDesc
        viewController.labelCityName.text = weatherInfo.location
        viewController.labelTemperatureHiLo.text =
            "H " + String(describing: weatherInfo.tempMax!) + "°" +
            " L " + String(describing: weatherInfo.tempMin!) + "°"
        viewController.labelHumidity.text = "Humidity: " + String(describing: weatherInfo.tempCurrent!) + "%"
        viewController.labelWind.text = "Wind: " + String(describing: weatherInfo.windSpeed!) + " km/h"
        viewController.labelPressure.text = "Pressure: " + String(describing: weatherInfo.pressure!) + " hPa"
    }
    
    private func updateOutfitPreview() {
        guard let weatherInfo = self.weatherInfo else {
            return
        }
        
        outfit = outfitService.generateOutfitFor(weatherInfo: weatherInfo)
        
        viewController.outfitCollectionView.reloadData()
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
    
    func addRoundedBorders(toCell : UICollectionViewCell) {
        toCell.layer.cornerRadius = NumberConstants.cornerRadius
        toCell.layer.shouldRasterize = true
    }
    
    func configureCollectionViewLayout() {
        guard let collectionView = viewController.outfitCollectionView, let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let itemWidth = cellHeight
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
    }
    
    func fetchWeather() -> Observable<WeatherResponse> {
        return networking.fetchWeather()
    }
}
