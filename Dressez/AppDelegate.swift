//
//  AppDelegate.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationService: NavigationService!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        initNavigationService()

        return true
    }
    
    func initNavigationService() {
        guard let `window` = window else {
            fatalError("No window")
        }
        navigationService = NavigationService()
        navigationService.initWithHomeScreen(window: window)
    }
    
}

