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
        assignbackground()
        addRoundedBorders()
    }
    
    func fetchWeather(){
        
    viewModel.fetchWeather().subscribe(onNext: {(result) in
            self.onWeatherfetched(response: result)
        }, onError: {(error) in
            return
        }, onCompleted: {
        }, onDisposed: {
        }).addDisposableTo(bag)
    }
    
    func onWeatherfetched(response : WeatherResponse){
        presenter.updateView(with: response)
    }
    
    func assignbackground(){
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func addRoundedBorders(){
        reccomendationsView.layer.cornerRadius = CGFloat(10)
        reccomendationsView.layer.shadowColor = UIColor.black.cgColor
        reccomendationsView.layer.shadowOpacity = 0.5
        reccomendationsView.layer.shadowOffset = CGSize(width: 3, height: 3)
        reccomendationsView.layer.shadowRadius = 05
        reccomendationsView.layer.shadowPath = UIBezierPath(rect: reccomendationsView.bounds).cgPath
        reccomendationsView.layer.shouldRasterize = true
    }
}
