//
//  ClosetController.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit
import CoreData

enum ImagePickerType {
    case gallery
    case camera
}

class ClosetScreenController: BaseViewController {
    
    @IBOutlet weak var noClothesLabel: UILabel!
    
    fileprivate let picker = UIImagePickerController()
    fileprivate let reuseIdentifier = "collectionCell"
    var items: [ClothingItem] = [] {
        didSet {
            presenter.checkClothesQuantity()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ClosetScreenPresenter! {
        return basePresenter as! ClosetScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
        configureRightBarButtonItem()
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        picker.delegate = self
        presenter.configureImagePickerController(picker: picker)
        items = presenter.fetchAllItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.assignBackground()
        presenter.configureCollectionViewLayout()
    }
    
    
    func configureRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.openImagePicker))
    }
    
    
    func openImagePicker(selector: UIBarButtonItem) {
        let pickerType = createActionSheet(title: nil, message: nil)
        let galleryAction = createAlertAction(title: StringConstants.photoGallery, handler: { _ in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        })
        let cameraAction = createAlertAction(title: StringConstants.camera, handler: { _ in
            self.picker.allowsEditing = false
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let availabilityAlert = self.createAlertDialog(with: nil, message: StringConstants.noCamera, buttonText: StringConstants.ok, handler: { _ in
                    self.dismiss(animated: true, completion: nil)})
                self.present(availabilityAlert, animated: true, completion: nil)
            }
            else {
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }
        })
        pickerType.addAction(galleryAction)
        pickerType.addAction(cameraAction)
        self.present(pickerType, animated: true, completion: nil)
    }
}

extension ClosetScreenController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
        presenter.navigationService.pushToNewClothingItemScreen(navigationController: self.navigationController, image: chosenImage)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ClosetScreenController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionData = presenter.resultController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let current = presenter.fetchItem(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        if let image = current.image {
            return presenter.configureImageCollectionViewCell(cell: cell, image: image)
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = presenter.navigationService.controllerFactory(PresenterType: ItemDetailsPagePresenter.self) as ItemDetailsPageController
        detailsVC.modalTransitionStyle = .crossDissolve
        detailsVC.items = items
        detailsVC.currentIndex = indexPath.item
        
        let navController = NavigationController(rootViewController: detailsVC)
        navController.navigationBar.isTranslucent = true
        present(navController, animated: true, completion: nil)
    }
}
