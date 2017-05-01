//
//  ItemDetailsPageController.swift
//  Dressez
//
//  Created by Dora Stipković on 5/1/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import UIKit

class ItemDetailsPageController: BaseViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var containerView: UIView!
    
    var pageControllers: [UIViewController] = []
    var pageController: UIPageViewController!
    
    var items: [ClothingItem] = []
    var currentIndex: Int?
    var presenter: ItemDetailsPagePresenter! {
        return basePresenter as! ItemDetailsPagePresenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeGallery))
        presenter.setup()
        let pageControl = UIPageControl.appearance()
        presenter.configurePageControl(pageControl: pageControl)
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
        guard items.count > 0 else { return }

        for item in items {
            let scrollImageVC = presenter.navigationService.controllerFactory(PresenterType: ItemDetailsPresenter.self) as ItemDetailsScreenController
            scrollImageVC.item = item
            pageControllers.append(scrollImageVC)
        }
        
        pageController.dataSource = self
        if let index = currentIndex, index < items.count {
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
