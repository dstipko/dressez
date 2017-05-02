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
    
    private let spacing : CGFloat = 10
    private let cellHeight : CGFloat = 100
    
    var navigationService: NavigationService!
    var persistenceService: PersistenceService!
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
        viewController.labelOutfit.text = StringConstants.homeScreenOutfitLabel
        viewController.labelOutfitWarning.text = StringConstants.homeScreenOutfitWarningLabel
        viewController.labelOutfitWarning.isHidden = true
        viewController.shuffleOutfitButton.setTitle(StringConstants.homeScreenShuffleButton, for: .normal)
        viewController.shuffleOutfitButton.setTitleColor(ColorConstants.lightBlue, for: .normal)
        viewController.shuffleOutfitButton.layer.cornerRadius = NumberConstants.cornerRadius
        viewController.shuffleOutfitButton.layer.borderWidth = NumberConstants.borderWidth
        viewController.shuffleOutfitButton.layer.borderColor = ColorConstants.lightBlue.cgColor
        viewController.shuffleOutfitButton.layer.masksToBounds = true
        viewController.outfitLoader.hidesWhenStopped = true
        
        viewController.outfitLoader.startAnimating()
    }
    
    func updateView(with weatherResponse: WeatherResponse) {
        weatherInfo = weatherResponse
        
        updateWeatherPreview()
        updateOutfitPreview()
    }
    
    private func updateWeatherPreview() {
        guard let weatherInfo = self.weatherInfo else { return }
        
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

    func updateOutfitPreview() {
        guard let weatherInfo = self.weatherInfo else { return }
        
        viewController.outfitLoader.startAnimating()
        outfit = outfitService.generateOutfit(for: weatherInfo)
        viewController.outfitLoader.stopAnimating()
        
        viewController.labelOutfitWarning.isHidden = outfit != nil
        
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
    
    func addRoundedBorders(to view : UIView) {
        view.layer.cornerRadius = NumberConstants.cornerRadius
        view.layer.shouldRasterize = true
    }
    
    func configureCollectionViewLayout() {
        guard let collectionView = viewController.outfitCollectionView, let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        collectionView.layer.cornerRadius = NumberConstants.cornerRadius
        collectionView.layer.masksToBounds = true
        collectionView.layer.borderWidth = NumberConstants.borderWidth
        collectionView.layer.borderColor = UIColor.white.cgColor
        
        let itemWidth = cellHeight
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
    }
    
    func checkNetworkStatus(){
        if (viewController.currentReachabilityStatus == .notReachable){
            viewController.outfitLoader.stopAnimating()
            let alert = viewController.createAlertDialog(with: StringConstants.networkUnavailible, message: StringConstants.networkUnavailibleMessage, buttonText: StringConstants.ok, handler:
                { action in
                    self.viewController.networkErrorLabel.isHidden = false
                    self.addRoundedBorders(to: self.viewController.networkErrorLabel)
                }
            )
            
            viewController.weatherLabels.forEach({$0.isHidden = true})
            viewController.labelOutfitWarning.isHidden = true
            viewController.present(alert, animated: true)
        } else {
            viewController.weatherLabels.forEach({$0.isHidden = false})
            self.viewController.networkErrorLabel.isHidden = true
        }
    }
    
    func fetchWeather() -> Observable<WeatherResponse> {
        return networking.fetchWeather()
    }
}
