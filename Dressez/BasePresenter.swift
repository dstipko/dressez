//
//  BasePresenter.swift
//  LikeUs
//
//  Created by Filip Fajdetic on 29/12/2016.
//  Copyright © 2016 Filip Fajdetic. All rights reserved.
//

import Foundation

protocol BasePresenter {
	
	init()
	
	weak var baseViewController: BaseViewController! { get set }
}
