//
//  ImageGalleryViewController.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var containerView: UIView!
    
    var pageControllers: [UIViewController] = []
    var pageController: UIPageViewController!
    
    var images: [UIImage] = []
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeGallery))
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = ColorConstants.green
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.backgroundColor = UIColor.clear
        
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        addPageViewControllers()
        
        addChildViewController(pageController)
        
        containerView.addSubview(pageController.view)
        pageController.didMove(toParentViewController: self)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageController.view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    func closeGallery(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func addPageViewControllers() {
        guard images.count > 0 else { return }

        for image in images {
            let scrollImageVC = ScrollImageViewController(nibName: "ScrollImageViewController", bundle: nil)
            scrollImageVC.image = image
            pageControllers.append(scrollImageVC)
        }
        
        pageController.dataSource = self
        if let index = currentIndex, index < images.count {
            pageController.setViewControllers([pageControllers[index]], direction: .forward, animated: true, completion: nil)
        } else {
            pageController.setViewControllers([pageControllers.first!], direction: .forward, animated: true, completion: nil)
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentindex = pageControllers.index(of: viewController)!
        if currentindex == 0 {
            return nil
        } else {
            return pageControllers[currentindex-1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentindex = pageControllers.index(of: viewController)!
        if currentindex == pageControllers.count-1 {
            return nil
        } else {
            return pageControllers[currentindex+1]
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let vc = pageController.viewControllers?.first {
            return pageControllers.index(of: vc) ?? 0
        } else {
            return 0
        }
        
    }

}
