//
//  GeneralExtensions.swift
//  Dressez
//
//  Created by Dora Stipković on 4/30/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func onlyHasWhitespaces() -> Bool {
        let trimmed = self.replacingOccurrences(of: " ", with: "")
        return trimmed == "" ? true : false
    }
}

extension UIViewController {    
    func createAlertController(title: String?, message: String?, style: UIAlertControllerStyle) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.view.tintColor = Colors.green
        return alert
    }
    
    func createAlertAction(title: String?, completionHandler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: completionHandler)

    }
}
