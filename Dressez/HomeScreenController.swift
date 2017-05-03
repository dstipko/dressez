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
    
    @IBOutlet var animatedOutfitViews: [UIView]!
    var bag : DisposeBag = DisposeBag()
    var selected: UIImageView?
    fileprivate var transition = PopAnimator()
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
        
        fetchWeather()
    }
    
    override func viewDidLayoutSubviews() {
        presenter.assignBackground()
        presenter.configureCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.checkNetworkStatus()
        
        self.imageConstraint.constant  = -self.view.frame.width/2
        self.labelsConstraint.constant = self.view.frame.width/4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateWeatherInfo()
    }
    
    func animateWeatherInfo() {
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
                        
        }
        )
    }
    
    func animateOutfit() {
        UIView.animate(withDuration: 1.0,
                       delay: 1,
                       options: .curveEaseIn,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.animatedOutfitViews.forEach({$0.alpha = 100})
        },
                       completion: { finished in
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
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        selected = cell.imageView
        
        let navigationController = NavigationController(rootViewController: pageController)
        navigationController.title = StringConstants.todaysOutfit
        navigationController.transitioningDelegate = self
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func shuffleOutfit(_ sender: Any) {
        presenter.updateOutfitPreview()
    }
}

extension HomeScreenController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let selected = selected, let frame  = selected.superview?.convert(selected.frame, to: nil){
            transition.originFrame = frame
            transition.presenting = true
        }
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
