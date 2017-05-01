//
//  ScrollImagePresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

class ScrollImagePresenter: BasePresenter {
    
    var navigationService: NavigationService!
    var persistanceService: PersistanceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: ScrollImageViewController! {
        return baseViewController as! ScrollImageViewController
    }
    required init() {}
    
    func setup() {
        guard let item = viewController.item else { return }
        viewController.itemNameLabel.text = item.name
        viewController.itemTypeLabel.text = item.type.description()
        viewController.itemColorLabel.text = item.color.description()
        viewController.imageView.image = item.image
    }

}
