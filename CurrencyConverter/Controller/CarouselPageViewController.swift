//
//  CarouselPageViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 8/1/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation
import UIKit

class CarouselPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        addChild(pageController)
        view.addSubview(pageController.view)

        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageViewController.self])
        appearance.numberOfPages = 3
        appearance.pageIndicatorTintColor = UIColor(named: "mumfordIndigo")
        appearance.currentPageIndicatorTintColor = UIColor(named: "jupiterIndigo")

        for i in 0 ... 2 {
            var viewController = UIViewController()
            let textTitleArray = ["Where will you go?", "Save Favorites", "Premium Features"]
            let textSubtitleArray = ["Take over 150 currencies with you!", "Search and save your top 3 currencies", "Upgrade now to unlock!"]
            let imageNames = ["premiumPage1", "premiumPage2", "premiumPage3"]

            viewController = createCarouselItemControler(with: textTitleArray[i], with: textSubtitleArray[i], with: imageNames[i])
            controllers.append(viewController)
        }
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
    }

    
    func createCarouselItemControler(with titleText: String?, with subtitleText: String?, with itemImage: String?) -> UIViewController {
        let controller = UIViewController()
        controller.view = CarouselItem(titleText: titleText, subtitleText: subtitleText, itemImage: itemImage)
        return controller
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return nil
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return nil
            }
        }
        return nil
    }
        func presentationCount(for _: UIPageViewController) -> Int {
            return controllers.count
        }
        func presentationIndex(for _: UIPageViewController) -> Int {
            guard let firstViewController = viewControllers?.first,
                  let firstViewControllerIndex = controllers.firstIndex(of: firstViewController) else {
                    return 0
            }
            return firstViewControllerIndex
        }
}
