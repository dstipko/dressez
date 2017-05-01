//
//  HomeScreenController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit
import RxSwift

class HomeScreenController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var bag : DisposeBag = DisposeBag()
    private let reuseIdentifier = "collectionCell"
    private var closetItems : Array<ClothingItem> = []

    @IBOutlet weak var outfitCollectionView: UICollectionView!
    
    @IBOutlet weak var imageWeatherIcon: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelTemperatureHiLo: UILabel!
    @IBOutlet weak var labelWeatherDesc: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    
    @IBOutlet weak var networkErrorTextView: UITextView!
    
    var presenter: HomeScreenPresenter! {
        return basePresenter as! HomeScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.checkNetworkStatus()
        
        closetItems = (presenter.persistanceService.fetchAllItems().fetchedObjects as! Array<ClothingItem>)
        
        outfitCollectionView.delegate = self
        outfitCollectionView.dataSource = self
        
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        self.outfitCollectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        presenter.setup()
        
        fetchWeather()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        presenter.assignBackground()
        presenter.configureCollectionViewLayout()
    }
    
    func fetchWeather(){
        presenter.fetchWeather().subscribe(onNext: {(result) in
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return closetItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = closetItems[indexPath.item] as ClothingItem
        let cell = outfitCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        presenter.addRoundedBorders(toView : cell)
        cell.imageView.image = object.image
        
        return cell
    }
}
