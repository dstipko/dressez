//
//  GeneralExtensions.swift
//  Dressez
//
//  Created by Dora Stipković on 4/30/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

extension String {
    func onlyHasWhitespaces() -> Bool {
        let trimmed = self.replacingOccurrences(of: " ", with: "")
        return trimmed == "" ? true : false
    }
}
