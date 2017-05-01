//
//  ScrollImageViewController.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class ScrollImageViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!

    @IBOutlet weak var itemColorLabel: UILabel!
    @IBOutlet weak var itemTypeLabel: UILabel!
    var item: ClothingItem?
    
    var presenter: ScrollImagePresenter! {
        return basePresenter as! ScrollImagePresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        presenter.setup()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
