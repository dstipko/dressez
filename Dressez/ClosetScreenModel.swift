
//
//  ClosetModel.swift
//  Dressez
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class ClosetScreenModel: BaseViewModel {
    
    var navigationService: NavigationService!
    var networking: NetworkingService!
    
    required init() {}
    
    func closeImagePicker(viewController: UIViewController) {
        navigationService.dismissViewController(viewController: viewController)
    }
    
    func saveChosenImage(image: UIImage) {
        
    }
    
}
