//
//  BasePresenter.swift
//  LikeUs
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

protocol BasePresenter {
	
	init()
	
	weak var baseViewController: BaseViewController! { get set }
    var networking: NetworkingService! { get set }
    var navigationService: NavigationService! { get set }
    var persistanceService : PersistanceService! { get set }
}
