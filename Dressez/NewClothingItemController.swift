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
        
        configureRightBarButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
   
    func saveClothingItem(selector: UIBarButtonItem) {
        if let colorId = itemColor, let typeId = itemType,let type = ItemType(rawValue: typeId), let color = ItemColor(rawValue: colorId), let nameText = nameTextField.text, let name = nameText.onlyHasWhitespaces() ? nil : nameText {
            
            DispatchQueue.main.async {
                self.presenter.persistenceService.createClothingItem(name: name, image: self.image, type: type, color: color, completion: { item in
                    return
                })
            }
            self.presenter.navigationService.popController(navigationController: self.navigationController)
        }
        else {
            let alert = createAlertDialog(with: nil, message: StringConstants.requiredFields, buttonText: StringConstants.ok, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func configureRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(self.saveClothingItem))
    }
}

extension NewClothingItemController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case typeTextField:
            let typeMenu = createActionSheet(title: nil, message: StringConstants.selectType)
            for type in ItemType.allValues {
                let colorAction = createAlertAction(title: type.description(), handler: { _ in
                    self.itemType = type.rawValue
                    self.typeTextField.text = type.description()
                    self.dismiss(animated: true, completion: nil)
                    return
                })
                typeMenu.addAction(colorAction)
            }
            self.present(typeMenu, animated: true, completion: nil)
        case colorTextField:
            let colorsMenu = createActionSheet(title: nil, message: StringConstants.selectColor)
            for color in ItemColor.allValues {
                let colorAction = createAlertAction(title: color.description(), handler: { _ in
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
