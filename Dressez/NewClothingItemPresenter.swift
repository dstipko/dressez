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
        viewController.navigationItem.title = Strings.title
        imageView.image = image
        imageView.layer.cornerRadius = Numbers.cornerRadius
        imageView.layer.masksToBounds = true
        
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = Numbers.cornerRadius
        saveButton.layer.masksToBounds = true
    }
    
    func configureTextFields(nameTextField: UITextField, typeTextField: UITextField, colorTextField: UITextField) {
        nameTextField.placeholder = Strings.newClothingItemNameFieldPlaceholder
        typeTextField.placeholder = Strings.newClothingItemTypeFieldPlaceholder
        colorTextField.placeholder = Strings.newClothingItemColorFieldPlaceholder
    }
    
    func assignbackground() {
        viewController.view.backgroundColor = Colors.green
    }
}
