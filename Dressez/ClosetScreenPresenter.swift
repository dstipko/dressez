//
//  ClosetPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class ClosetScreenPresenter: BasePresenter {
    
    var navigationService: NavigationService!
    var persistanceService: PersistanceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: ClosetScreenController! {
        return baseViewController as! ClosetScreenController
    }
    
    private let numberOfCellsInRow : CGFloat = 3
    private let spacing : CGFloat = 5
    private let cellHeight : CGFloat = 90
    
    required init() {}
    
    func setup() {
        viewController.navigationItem.title = "Closet"
    }

    func configureCollectionViewCell(cell: CollectionViewCell, image: UIImage) -> CollectionViewCell {
        cell.imageView.image = image
        return cell
    }
    
    func configureCollectionViewLayout() {
        guard let collectionView = viewController.collectionView, let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
        }
        let width = collectionView.frame.width
        let itemWidth = (width - (numberOfCellsInRow + 1) * spacing) / numberOfCellsInRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
    }
    
    func assignBackground() {
        guard let backgroundImage = UIImage(named: "background_blurred") else {
            viewController.view.backgroundColor = ColorConstants.green
            return
        }
        
        UIGraphicsBeginImageContext(viewController.view.frame.size)
        backgroundImage.draw(in: viewController.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        viewController.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func configureImagePickerController() {
        baseViewPresenter.picker.navigationBar.tintColor = ColorConstants.green
    }
}
