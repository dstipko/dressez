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
    
    weak var baseViewController: BaseViewController!
    weak var viewController: NewClothingItemController! {
        return baseViewController as! NewClothingItemController
    }
    
    required init() {}
    
    func setup(image: UIImage, imageView: UIImageView) {
        viewController.navigationItem.title = StringConstants.title
        imageView.image = image
    }

    func configureTextFields(nameTextField: UITextField, typeTextField: UITextField, colorTextField: UITextField) {
        typeTextField.isUserInteractionEnabled = false
        colorTextField.isUserInteractionEnabled = false 
    }
    
    func createAlertController(title: String?, message: String?, style: UIAlertControllerStyle) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: style)
    }
    
    func createAlertAction(title: String?, completionHandler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: completionHandler)
    }
    
    
}