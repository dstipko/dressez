//
//  CollectionViewCell.swift
//  Dressez
//
//  Created by Dora Stipković on 4/30/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = NumberConstants.cornerRadius
        layer.masksToBounds = true
    }
}
