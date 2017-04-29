//
//  BaseViewModel.swift
//  LikeUs
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation


protocol ModelType {
	var errors: Array<RequestError>? { get set }
}

class BaseViewModel {
	var networking: NetworkingService!
	var navigationService: NavigationService!
    var persistanceService : PersistanceService!
    
    required init(networking: NetworkingService, navigation: NavigationService, persistance: PersistanceService) {
        self.networking = networking
        self.navigationService = navigation
        self.persistanceService = persistance
    }
}

