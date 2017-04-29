//
//  ClosetController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

enum ImagePickerType {
    case gallery
    case camera
}

class ClosetScreenController: BaseViewController {

    var viewModel: ClosetScreenModel! {
        return baseViewModel as! ClosetScreenModel
    }
    var presenter: ClosetScreenPresenter! {
        return basePresenter as! ClosetScreenPresenter
    }
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
        configureRightBarButtonItem()
        picker.delegate = self
    }
    
    
    func configureRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.openImagePicker))
    }
    
    
    func openImagePicker(selector: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
}

extension ClosetScreenController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //viewModel.saveChosenImage(image: chosenImage)
        //viewModel.closeImagePicker(viewController: picker)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //viewModel.closeImagePicker(viewController: picker)
        dismiss(animated: true, completion: nil)
    }
}

