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
    weak var baseViewController: BaseViewController!
    weak var viewController: HomeScreenController! {
        return baseViewController as! HomeScreenController
    }
    
    required init() { }
    
    func setup() {
        viewController.navigationItem.title = "Dressez"
    }
    
    func updateView(with : WeatherResponse) {
        viewController.imageWeatherIcon.image = IconUtil.getAppropriateWeatherIcon(weatherID: with.id!)
        
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
        toCell.layer.shadowColor = UIColor.black.cgColor
        toCell.layer.shadowOpacity = 0.5
        toCell.layer.shadowOffset = CGSize(width: 3, height: 3)
        toCell.layer.shadowRadius = 05
        toCell.layer.shadowPath = UIBezierPath(rect: toCell.bounds).cgPath
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
