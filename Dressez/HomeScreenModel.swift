//
//  HomeScreenModel.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

class HomeScreenModel: BaseViewModel {

    var navigationService: NavigationService!
    var networking: NetworkingService!
    var persistanceService: PersistanceService!
    
    required init() {}
}
