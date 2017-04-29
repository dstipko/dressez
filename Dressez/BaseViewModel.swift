//
//  BaseViewModel.swift
//  LikeUs
//
//  Created by Filip Fajdetic on 13/10/16.
//  Copyright © 2016 Filip Fajdetic. All rights reserved.
//

import Foundation


protocol ModelType {
	var errors: Array<RequestError>? { get set }
}

protocol BaseViewModel {
	var networking: NetworkingService! { get set }
	var navigationService: NavigationService! { get set }
	
	init()
	
	func extractError(response: HTTPURLResponse, data: ModelType?) -> Error?
}

extension BaseViewModel {
	
	func extractError(response: HTTPURLResponse, data: ModelType?) -> Error? {
		if response.statusCode != 200 {
			return response.statusCode as? Error
		}
		if data?.errors?.count != 0 {
			return data?.errors?.first
		}
		
		return nil
	}
	
}
