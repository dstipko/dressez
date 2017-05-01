//
//  ItemDetailsPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

class ItemDetailsPresenter: BasePresenter {
    
    var navigationService: NavigationService!
    var persistanceService: PersistanceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: ItemDetailsScreenController! {
        return baseViewController as! ItemDetailsScreenController
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
