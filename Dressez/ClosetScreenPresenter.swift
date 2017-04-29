//
//  ClosetPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class ClosetScreenPresenter: BasePresenter {
    
    weak var baseViewController: BaseViewController!
    weak var viewController: ClosetScreenController! {
        return baseViewController as! ClosetScreenController
    }
    
    required init() {}
    
    func setup() {
        viewController.navigationItem.title = "Dressez"
    }
    
}
