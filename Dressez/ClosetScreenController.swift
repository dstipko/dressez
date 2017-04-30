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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ClosetScreenModel! {
        return baseViewModel as! ClosetScreenModel
    }
    var presenter: ClosetScreenPresenter! {
        return basePresenter as! ClosetScreenPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultController = viewModel.persistanceService.fetchAllItems()
        presenter.setup()
        configureRightBarButtonItem()
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        resultController.delegate = self
        picker.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.configureCollectionViewLayout()
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
        dismiss(animated: true, completion: nil)
        viewModel.navigationService.pushToNewClothingItemScreen(navigationController: self.navigationController, image: chosenImage)
        
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
}

extension ClosetScreenController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.reloadData()
    }
}

