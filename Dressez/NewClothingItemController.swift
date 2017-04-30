//
//  NewClothingItemController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit
import RxSwift

class NewClothingItemController: BaseViewController {
    
    @IBOutlet weak var clothingItemImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var viewModel: NewClothingItemModel! {
        return baseViewModel as! NewClothingItemModel
    }
    var presenter: NewClothingItemPresenter! {
        return basePresenter as! NewClothingItemPresenter
    }
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup(image: image, imageView: clothingItemImageView)
        presenter.configureTextFields(nameTextField: nameTextField, typeTextField: typeTextField, colorTextField: colorTextField)
    }
   
    @IBAction func saveClothingItem(_ sender: Any) {
//        viewModel.persistanceService.createClothingItem(name: nameTextField.text, image: image, type: TypeEnum(rawValue: typeTextField.text), color: ColorEnum(rawValue: colorTextField.text), completion: nil)
        
    }
    @IBAction func showTypeActionSheet(_ sender: Any) {
        let typeMenu = UIAlertController(title: nil, message: "Select item type", preferredStyle: .actionSheet)
        for color in TypeEnum.allValues {
            let colorAction = UIAlertAction(title: color.rawValue, style: .default, handler: { _ in
                self.typeTextField.text = color.rawValue
                self.dismiss(animated: true, completion: nil)
                return
            })
            typeMenu.addAction(colorAction)
        }
        self.present(typeMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func showColorActionSheet(_ sender: Any) {
        let colorsMenu = UIAlertController(title: nil, message: "Select color", preferredStyle: .actionSheet)
        for color in ColorEnum.allValues {
            let colorAction = UIAlertAction(title: color.rawValue, style: .default, handler: { _ in
                self.colorTextField.text = color.rawValue
                self.dismiss(animated: true, completion: nil)
                return
            })
            colorsMenu.addAction(colorAction)
        }
        self.present(colorsMenu, animated: true, completion: nil)
        
    }
}
