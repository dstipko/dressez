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

    @IBOutlet weak var outfitCollectionView: UICollectionView!
    
    @IBOutlet weak var imageWeatherIcon: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelTemperatureHiLo: UILabel!
    @IBOutlet weak var labelWeatherDesc: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    
    var presenter: HomeScreenPresenter! {
        return basePresenter as! HomeScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
        closetItems = (presenter.persistenceService.fetchAllItems().fetchedObjects as! Array<ClothingItem>)
        
=======
>>>>>>> deeeaeb939b19fcee261a72b1606b37e4b480afe
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
        guard let outfit = presenter.outfit else {
            return 0
        }
        
        return outfit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = outfitCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        presenter.addRoundedBorders(toCell : cell)
        
        if let outfit = presenter.outfit {
            let object = outfit[indexPath.item] as ClothingItem
            cell.imageView.image = object.image
        }
        
        return cell
    }
}
