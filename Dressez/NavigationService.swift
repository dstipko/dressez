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
    
    mutating func initWithHomeScreen(window: UIWindow) {
        tabBarController = TabBarController()
        
        let homeScreenController = HomeScreenController()
        let homeNavigationController = NavigationController(rootViewController: homeScreenController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "web.png"), selectedImage: nil)
        
        let closetScreenController = ClosetScreenController()
        let closetNavigationController = NavigationController(rootViewController: closetScreenController)
        closetNavigationController.tabBarItem = UITabBarItem(title: "Closet", image: UIImage(named: "web.png"), selectedImage: nil)
        
        tabBarController.viewControllers = [homeNavigationController,closetNavigationController]
        
        window.rootViewController = tabBarController
    }
}
