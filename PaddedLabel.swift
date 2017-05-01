//
//  PaddedLabel.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: NumberConstants.labelTopBottomPadding, left: NumberConstants.labelLeftRightPadding,
                                                bottom: NumberConstants.labelTopBottomPadding, right: NumberConstants.labelLeftRightPadding)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
