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
    
    var presenter: NewClothingItemPresenter! {
        return basePresenter as! NewClothingItemPresenter
    }
    
    var image: UIImage!
    fileprivate var itemType: Int?
    fileprivate var itemColor: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
        presenter.configureTextFields()
        
        typeTextField.delegate = self
        colorTextField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.assignBackground()
    }
   
    @IBAction func saveClothingItem(_ sender: Any) {
        if let colorId = itemColor, let typeId = itemType,let type = ItemType(rawValue: typeId), let color = ItemColor(rawValue: colorId), let nameText = nameTextField.text, let name = nameText.onlyHasWhitespaces() ? nil : nameText {
            
            DispatchQueue.main.async {
                self.presenter.persistenceService.createClothingItem(name: name, image: self.image, type: type, color: color, completion: { item in
                    return
                })
            }
            self.presenter.navigationService.popController(navigationController: self.navigationController)
        }
        else {
            let alert = createAlertController(title: nil, message: StringConstants.requiredFields, style: .alert)
            let okAction = createAlertAction(title: StringConstants.ok, completionHandler: { _ in
                self.dismiss(animated: true, completion: nil)
                
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension NewClothingItemController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case typeTextField:
            let typeMenu = createAlertController(title: nil, message: StringConstants.selectType, style: .actionSheet)
            for type in ItemType.allValues {
                let colorAction = createAlertAction(title: type.description(), completionHandler: { _ in
                    self.itemType = type.rawValue
                    self.typeTextField.text = type.description()
                    self.dismiss(animated: true, completion: nil)
                    return
                })
                typeMenu.addAction(colorAction)
            }
            self.present(typeMenu, animated: true, completion: nil)
        case colorTextField:
            let colorsMenu = createAlertController(title: nil, message: StringConstants.selectColor, style: .actionSheet)
            for color in ItemColor.allValues {
                let colorAction = createAlertAction(title: color.description(), completionHandler: { _ in
                    self.itemColor = color.rawValue
                    self.colorTextField.text = color.description()
                    self.dismiss(animated: true, completion: nil)
                    return
                })
                colorsMenu.addAction(colorAction)
            }
            self.present(colorsMenu, animated: true, completion: nil)
        default:
            return false
        }
        return false
    }
}
