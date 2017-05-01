//
//  ItemDetailsPagePresenter.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailsPagePresenter: BasePresenter {
    
    var navigationService: NavigationService!
    var persistenceService: PersistenceService!
    var networking: NetworkingService!
    weak var baseViewController: BaseViewController!
    weak var viewController: ItemDetailsPageController! {
        return baseViewController as! ItemDetailsPageController
    }
    
    required init() {}
    
    func setup() {
        viewController.containerView.backgroundColor = ColorConstants.green
    }
    
    func configurePageControl(pageControl: UIPageControl){
        
        pageControl.currentPageIndicatorTintColor = ColorConstants.darkGray
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = ColorConstants.green
    }
}
