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

    @IBOutlet weak var labelsConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageConstraint: NSLayoutConstraint!
    @IBOutlet var weatherLabels: [UIView]!
    @IBOutlet weak var outfitCollectionView: UICollectionView!
    @IBOutlet weak var imageWeatherIcon: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelTemperatureHiLo: UILabel!
    @IBOutlet weak var labelWeatherDesc: UILabel!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var labelOutfit: UILabel!
    @IBOutlet weak var shuffleOutfitButton: UIButton!
    @IBOutlet weak var outfitLoader: UIActivityIndicatorView!
    @IBOutlet weak var labelOutfitWarning: UILabel!
    
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    var presenter: HomeScreenPresenter! {
        return basePresenter as! HomeScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        outfitCollectionView.delegate = self
        outfitCollectionView.dataSource = self
        
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        self.outfitCollectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        presenter.setup()

        let con = self.imageConstraint.constant
        
        self.imageConstraint.constant  = -125
        self.labelsConstraint.constant = 50

        fetchWeather()
    }
    
    override func viewDidLayoutSubviews() {
        presenter.assignBackground()
        presenter.configureCollectionViewLayout()
        let wi = self.view.frame.width
//        self.constraint.constant = -self.view.frame.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.checkNetworkStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateScreen()
        }

    func animateScreen() {
        self.imageConstraint.constant = -self.view.frame.width/4
        self.labelsConstraint.constant = 0
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.imageWeatherIcon.alpha = 100
                        self.weatherLabels.forEach({$0.alpha = 100})

        },
                       completion: { finished in
                        print("animated")
                        //                        
                    }
        )
    }
    
    func animateOutfit() {
        UIView.animate(withDuration: 1.0,
                       delay: 1,
                       options: .curveEaseIn,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.labelOutfitWarning.alpha = 100

        },
                       completion: { finished in
                        print("animated")
        }
        )
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

        presenter.addRoundedBorders(to: cell)
        
        if let outfit = presenter.outfit {
            let object = outfit[indexPath.item] as ClothingItem
            cell.imageView.image = object.image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let outfit = presenter.outfit else { return }
        let pageController = presenter.navigationService.controllerFactory(PresenterType: ItemDetailsPagePresenter.self) as ItemDetailsPageController
        pageController.modalTransitionStyle = .crossDissolve
        pageController.items = outfit
        pageController.currentIndex = indexPath.item
        
        let navigationController = NavigationController(rootViewController: pageController)
        navigationController.title = StringConstants.todaysOutfit
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func shuffleOutfit(_ sender: Any) {
        presenter.updateOutfitPreview()
    }
}
