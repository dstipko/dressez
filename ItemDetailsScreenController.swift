//
//  ItemDetailsScreenController.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class ItemDetailsScreenController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!

    @IBOutlet weak var itemColorLabel: UILabel!
    @IBOutlet weak var itemTypeLabel: UILabel!
    var item: ClothingItem?
    
    var presenter: ItemDetailsPresenter! {
        return basePresenter as! ItemDetailsPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
    }
}
