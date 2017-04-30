//
//  HomeScreenController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit
import RxSwift

class HomeScreenController: BaseViewController {

    var bag : DisposeBag = DisposeBag()

    @IBOutlet weak var reccomendationsView: UIView!
    @IBOutlet weak var imageWeatherIcon: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelTemperatureHiLo: UILabel!
    @IBOutlet weak var labelWeatherDesc: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    
    var viewModel: HomeScreenModel! {
        return baseViewModel as! HomeScreenModel
    }
    var presenter: HomeScreenPresenter! {
        return basePresenter as! HomeScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setup()
        
        fetchWeather()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.assignbackground()
        presenter.addRoundedBorders()
    }
    
    func fetchWeather(){
        viewModel.fetchWeather().subscribe(onNext: {(result) in
                self.onWeatherFetched(response: result)
            }, onError: {(error) in
                return
            }, onCompleted: {
            }, onDisposed: {
            }
        ).addDisposableTo(bag)
    }
    
    func onWeatherFetched(response : WeatherResponse){
        presenter.updateView(with: response)
    }
}
