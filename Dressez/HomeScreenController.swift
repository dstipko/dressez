//
//  HomeScreenController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class HomeScreenController: BaseViewController {

    var viewModel: HomeScreenModel! {
        return baseViewModel as! HomeScreenModel
    }
    var presenter: HomeScreenPresenter! {
        return basePresenter as! HomeScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
