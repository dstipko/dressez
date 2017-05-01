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
    
    func addRoundedBorders(toView : UIView) {
        toView.layer.cornerRadius = NumberConstants.cornerRadius
        toView.layer.shouldRasterize = true
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
    
    func checkNetworkStatus(){
        if (viewController.currentReachabilityStatus == .notReachable){
            let alert = UIAlertController(title: "Network unavailible", message: "Please check your internet connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                // perhaps use action.title here
            })
            
            viewController.present(alert, animated: true)
            
//            viewController.networkErrorTextView.isHidden = false
//            addRoundedBorders(toView: viewController.networkErrorTextView )
        }
    }
    
    func fetchWeather() -> Observable<WeatherResponse> {
        return networking.fetchWeather()
    }
}
