//
//  HomeScreenController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class HomeScreenController: UIViewController {

    let viewModel = HomeScreenModel()
    let presenter = HomeScreenPresenter()
    let networking = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networking.fetchWeather()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
