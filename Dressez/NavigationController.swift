//
//  NavigationController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = true
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.tintColor = ColorConstants.green
        navigationBar.barTintColor = ColorConstants.barsDefault
    }
    
}
