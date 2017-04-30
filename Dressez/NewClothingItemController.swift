//
//  NewClothingItemController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//
import Foundation
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
    private var itemType: Int?
    private var itemColor: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup(image: image, imageView: clothingItemImageView)
        presenter.configureTextFields(nameTextField: nameTextField, typeTextField: typeTextField, colorTextField: colorTextField)
    }
   
    @IBAction func saveClothingItem(_ sender: Any) {
        if let colorId = itemColor, let typeId = itemType,let type = ItemType(rawValue: typeId), let color = ItemColor(rawValue: colorId), let nameText = nameTextField.text, let name = nameText.onlyHasWhitespaces() ? nil : nameText {
            
            DispatchQueue.main.async {
                self.viewModel.persistanceService.createClothingItem(name: name, image: self.image, type: type, color: color, completion: { item in
                    return
                })
            }
            self.viewModel.navigationService.popController(navigationController: self.navigationController)
        }
        else {
            let alert = presenter.createAlertController(title: nil, message: StringConstants.requiredFields, style: .alert)
            let okAction = presenter.createAlertAction(title: StringConstants.ok, completionHandler: { _ in
                self.dismiss(animated: true, completion: nil)
                
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func showTypeActionSheet(_ sender: Any) {
        let typeMenu = presenter.createAlertController(title: nil, message: StringConstants.selectType, style: .actionSheet)
        for type in ItemType.allValues {
            let colorAction = presenter.createAlertAction(title: type.description(), completionHandler: { _ in
                self.itemType = type.rawValue
                self.typeTextField.text = type.description()
                self.dismiss(animated: true, completion: nil)
                return
            })
            typeMenu.addAction(colorAction)
        }
        self.present(typeMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func showColorActionSheet(_ sender: Any) {
        let colorsMenu = presenter.createAlertController(title: nil, message: StringConstants.selectColor, style: .actionSheet)
        for color in ItemColor.allValues {
            let colorAction = presenter.createAlertAction(title: color.description(), completionHandler: { _ in
                self.itemColor = color.rawValue
                self.colorTextField.text = color.description()
                self.dismiss(animated: true, completion: nil)
                return
            })
            colorsMenu.addAction(colorAction)
        }
        self.present(colorsMenu, animated: true, completion: nil)
        
    }
}
