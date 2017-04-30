//
//  RequestError.swift
//  LikeUs
//
//  Created by Dora Stipković on 4/29/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
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
