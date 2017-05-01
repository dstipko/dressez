//
//  NewClothingItemPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class NewClothingItemPresenter: BasePresenter {
    
    var navigationService: NavigationService!
    var persistenceService: PersistenceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: NewClothingItemController! {
        return baseViewController as! NewClothingItemController
    }

    required init() {}
    
    func setup() {
        viewController.navigationItem.title = StringConstants.title
        viewController.clothingItemImageView.image = viewController.image
        viewController.clothingItemImageView.contentMode = .scaleAspectFit
        viewController.clothingItemImageView.layer.cornerRadius = NumberConstants.cornerRadius
        viewController.clothingItemImageView.layer.masksToBounds = true
        
        viewController.saveButton.setTitleColor(.white, for: .normal)
        viewController.saveButton.layer.cornerRadius = NumberConstants.cornerRadius
        viewController.saveButton.layer.masksToBounds = true
    }
    
    func configureTextFields() {
        viewController.nameTextField.placeholder = StringConstants.newClothingItemNameFieldPlaceholder
        viewController.typeTextField.placeholder = StringConstants.newClothingItemTypeFieldPlaceholder
        viewController.colorTextField.placeholder = StringConstants.newClothingItemColorFieldPlaceholder
    }
    
    func assignBackground() {
        viewController.view.backgroundColor = ColorConstants.green
    }
}
