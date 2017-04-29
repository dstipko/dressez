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
    var persistanceService: PersistanceService!
    
    required init() {}
    
    func saveChosenImage(image: UIImage) {
        
    }
    
}
