//
//  TabBarController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.isOpaque = true
        tabBar.barStyle = UIBarStyle.default
        tabBar.tintColor = Colors.green
        tabBar.barTintColor = Colors.barsDefault
    }

}
