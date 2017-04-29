//
//  NetworkingService.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import CoreLocation

class NetworkingService: NSObject, CLLocationManagerDelegate {
    
    fileprivate let url = "http://api.openweathermap.org/data/2.5/weather"
    fileprivate let appId = "1aa4851814df949a215d4b588a284817"
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        setupLocationManager()
    }
    
    func fetchWeather() {
        guard let currentLocation = locationManager.location?.coordinate else { return }
    
        let params: [String: Any]? = [
            "lat": currentLocation.latitude,
            "lon": currentLocation.longitude,
            "APPID": appId
        ]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseObject { (response: DataResponse<WeatherResponse>) in
            
            switch response.result {
            case .success:
                if let weatherResponse = response.result.value, let id = weatherResponse.id {
                    print(id)
                }
            case .failure:
                print(response)
                
            }
        }
    }
    
    func setupLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}
