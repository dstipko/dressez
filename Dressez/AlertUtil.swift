//
//  AlertUtil.swift
//  Dressez
//
//  Created by Ivan Anic on 02/05/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import UIKit

class AlertUtil {

    static func createAlertDialog(with title: String, message: String, buttonText: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: handler))
        
        return alert
    }
}
