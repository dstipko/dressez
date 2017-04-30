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
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 26)]
        navigationBar.barStyle = UIBarStyle.default
        navigationBar.tintColor = Colors.green
        navigationBar.barTintColor = Colors.barsDefault
    }
    
}
