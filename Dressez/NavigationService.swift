//
//  NavigationService.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

struct NavigationService {
    
    var tabBarController: TabBarController!
    let networking = NetworkingService()
    var persistanceService = PersistanceService()
    
    mutating func initWithHomeScreen(window: UIWindow) {
        tabBarController = TabBarController()
        
        let homeScreenController : HomeScreenController = controllerFactory(PresenterType: HomeScreenPresenter.self)
        let homeNavigationController = NavigationController(rootViewController: homeScreenController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "web.png"), selectedImage: nil)
        
        let closetScreenController: ClosetScreenController = controllerFactory(PresenterType: ClosetScreenPresenter.self)
        
        let closetNavigationController = NavigationController(rootViewController: closetScreenController)
        closetNavigationController.tabBarItem = UITabBarItem(title: "Closet", image: UIImage(named: "web.png"), selectedImage: nil)
        
        tabBarController.viewControllers = [homeNavigationController,closetNavigationController]
        
        window.rootViewController = tabBarController
    }
    
    func controllerFactory<T: BaseViewController, P: BasePresenter>(PresenterType: P.Type) -> T {
        
        var presenter = PresenterType.init()
        presenter.networking = networking
        presenter.navigationService = self
        presenter.persistanceService = persistanceService
        let viewController: T = T()
        viewController.basePresenter = presenter
        presenter.baseViewController = viewController
        
        return viewController
    }
    
    func pushToNewClothingItemScreen(navigationController: UINavigationController?, image: UIImage) {
        
        let viewController: NewClothingItemController = controllerFactory(PresenterType: NewClothingItemPresenter.self)
        viewController.image = image
        
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popController(navigationController: UINavigationController?) {
        _ = navigationController?.popViewController(animated: true)
    }
}
