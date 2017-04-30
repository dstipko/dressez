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
import RxSwift

class NetworkingService: NSObject, CLLocationManagerDelegate {
    
    var response = Variable<WeatherResponse?>(nil)
    fileprivate let url = "http://api.openweathermap.org/data/2.5/weather"
    fileprivate let appId = "1aa4851814df949a215d4b588a284817"
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    func fetchWeather() -> Observable<WeatherResponse> {
        guard let currentLocation = locationManager.location?.coordinate else { return Observable.empty()}
        
        let params: [String: Any]? = [
            "lat": currentLocation.latitude,
            "lon": currentLocation.longitude,
            "units": "metric",
            "APPID": appId
        ]
        
        return Observable<WeatherResponse>.create { (observer) -> Disposable in
            Alamofire.request(self.url, method: .get, parameters: params, encoding: URLEncoding.default).responseObject { (response: DataResponse<WeatherResponse>) in
                
                switch response.result {
                case .success:
                    observer.onNext(response.result.value!)
                    observer.onCompleted()
                case .failure:
                    observer.onError(response.error!)
                }
            }
            return Disposables.create()
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
