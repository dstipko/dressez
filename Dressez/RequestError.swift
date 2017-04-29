//
//  RequestError.swift
//  LikeUs
//
//  Created by Filip Fajdetic on 17/11/2016.
//  Copyright © 2016 Filip Fajdetic. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestError: Mappable, Error {
	
	var message: String?
	
	required init?(map: Map) {
		
	}
	
	func mapping(map: Map) {
		message <- map["message"]
	}
	
}
