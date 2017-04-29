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
        
        let homeScreenController : HomeScreenController = controllerFactory(ViewModelType: HomeScreenModel.self, PresenterType: HomeScreenPresenter.self)
        let homeNavigationController = NavigationController(rootViewController: homeScreenController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "web.png"), selectedImage: nil)
        
        let closetScreenController: ClosetScreenController = controllerFactory(ViewModelType: ClosetScreenModel.self, PresenterType: ClosetScreenPresenter.self)
        
        let closetNavigationController = NavigationController(rootViewController: closetScreenController)
        closetNavigationController.tabBarItem = UITabBarItem(title: "Closet", image: UIImage(named: "web.png"), selectedImage: nil)
        
        tabBarController.viewControllers = [homeNavigationController,closetNavigationController]
        
        window.rootViewController = tabBarController
    }
    
    func controllerFactory<T: BaseViewController, V: BaseViewModel, P: BasePresenter>(ViewModelType: V.Type, PresenterType: P.Type) -> T {
        
        var viewModel = ViewModelType.init()
        viewModel.navigationService = self
        viewModel.networking = networking
        viewModel.persistanceService = persistanceService
        
        var presenter = PresenterType.init()
        let viewController: T = T()
        viewController.baseViewModel = viewModel
        viewController.basePresenter = presenter
        presenter.baseViewController = viewController
        
        return viewController
    }
}
