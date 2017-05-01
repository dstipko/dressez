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
    
    fileprivate var resultController: NSFetchedResultsController<NSFetchRequestResult>!
    fileprivate let picker = UIImagePickerController()
    fileprivate let reuseIdentifier = "collectionCell"
    fileprivate var items: [ClothingItem] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ClosetScreenPresenter! {
        return basePresenter as! ClosetScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultController = presenter.persistanceService.fetchAllItems()
        presenter.setup()
        configureRightBarButtonItem()
        items = resultController.fetchedObjects as! [ClothingItem]
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        resultController.delegate = self
        picker.delegate = self
        presenter.configureImagePickerController(picker: picker)
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
        let pickerType = createAlertController(title: nil, message: nil, style: .actionSheet)
        let galleryAction = createAlertAction(title: StringConstants.photoGallery, completionHandler: { _ in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        })
        let cameraAction = createAlertAction(title: StringConstants.camera, completionHandler: { _ in
            self.picker.allowsEditing = false
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let availabilityAlert = self.createAlertController(title: nil, message: StringConstants.noCamera, style: .alert)
                let okAction = self.createAlertAction(title: StringConstants.ok, completionHandler: { _ in
                    self.dismiss(animated: true, completion: nil)
                })
                availabilityAlert.addAction(okAction)
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
        guard let sectionData = resultController.sections?[section] else {
            return 0
        }
        return sectionData.numberOfObjects
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let current = resultController.object(at: indexPath) as! ClothingItem
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        if let image = current.image {
            return presenter.configureCollectionViewCell(cell: cell, image: image)
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let galleryVC = presenter.navigationService.controllerFactory(PresenterType: ImageGalleryPresenter.self) as ImageGalleryViewController
        galleryVC.modalTransitionStyle = .crossDissolve
        galleryVC.items = items
        galleryVC.currentIndex = indexPath.item
        
        let navController = NavigationController(rootViewController: galleryVC)
        navController.navigationBar.isTranslucent = true
        present(navController, animated: true, completion: nil)

    }
}

extension ClosetScreenController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}

