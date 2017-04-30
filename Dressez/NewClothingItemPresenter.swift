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
    var persistanceService: PersistanceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: NewClothingItemController! {
        return baseViewController as! NewClothingItemController
    }

    required init() {}
    
    func setup(image: UIImage, imageView: UIImageView, saveButton: UIButton) {
        viewController.navigationItem.title = StringConstants.title
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = NumberConstants.cornerRadius
        imageView.layer.masksToBounds = true
        
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = NumberConstants.cornerRadius
        saveButton.layer.masksToBounds = true
    }
    
    func configureTextFields(nameTextField: UITextField, typeTextField: UITextField, colorTextField: UITextField) {
        nameTextField.placeholder = StringConstants.newClothingItemNameFieldPlaceholder
        typeTextField.placeholder = StringConstants.newClothingItemTypeFieldPlaceholder
        colorTextField.placeholder = StringConstants.newClothingItemColorFieldPlaceholder
    }
    
    func assignBackground() {
        viewController.view.backgroundColor = ColorConstants.green
    }
}
