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
    func createActionSheet(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.view.tintColor = ColorConstants.green
        let cancelAction = UIAlertAction(title: StringConstants.cancel, style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelAction)
        return alert
    }
    
    func createAlertDialog(with title: String?, message: String?, buttonText: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: handler))
                return alert
    }
    
    func createAlertAction(title: String?, handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: handler)
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

