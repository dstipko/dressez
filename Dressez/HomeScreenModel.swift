//
//  HomeScreenModel.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import RxSwift

class HomeScreenModel: BaseViewModel {

    func fetchWeather() -> Observable<WeatherResponse> {
        return networking.fetchWeather()
    }
}
