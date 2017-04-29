//
//  HomeScreenPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

class HomeScreenPresenter: BasePresenter {
 
    required init() { }
    
    weak var baseViewController: BaseViewController!
    weak var viewController: HomeScreenController! {
        return baseViewController as! HomeScreenController
    }
}
