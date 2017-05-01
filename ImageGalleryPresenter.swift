//
//  ImageGalleryPresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

class ImageGalleryPresenter: BasePresenter {
    
    var navigationService: NavigationService!
    var persistanceService: PersistanceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: ImageGalleryViewController! {
        return baseViewController as! ImageGalleryViewController
    }
    required init() {}

}
