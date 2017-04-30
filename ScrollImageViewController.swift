//
//  ScrollImageViewController.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class ScrollImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
