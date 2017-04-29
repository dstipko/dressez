//
//  ClosetController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class ClosetScreenController: BaseViewController {

    var viewModel: ClosetScreenModel! {
        return baseViewModel as! ClosetScreenModel
    }
    var presenter: ClosetScreenPresenter! {
        return basePresenter as! ClosetScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
