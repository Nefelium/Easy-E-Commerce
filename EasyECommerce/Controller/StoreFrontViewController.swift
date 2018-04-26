//
//  StoreFrontViewController.swift
//  EasyECommerce
//
//  Created by admin on 13.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class StoreFrontViewController: UIPageViewController, UIPageViewControllerDataSource, UITabBarControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        let data = (DatabaseAdapter.baseAdapter.getFilterElement(predicate: "quantity != 0") as! Results<Devices>)
        if (index == NSNotFound)
        {
            return nil
        }
        index -= 1
        if (index < 0) {
            index = data.count-1
        }
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        let data = (DatabaseAdapter.baseAdapter.getFilterElement(predicate: "quantity != 0") as! Results<Devices>)
        if (index == NSNotFound)
        {
            return nil;
        }
        index += 1
        if (index >= data.count)
        {
            index = 0
        }
        return getViewControllerAtIndex(index: index)
    }
    
    func getViewControllerAtIndex(index: Int) -> PageContentViewController
    {
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        if !DatabaseAdapter.baseAdapter.isNoMoreShowInStoreFront(predicate: "quantity != 0") {
            let data = (DatabaseAdapter.baseAdapter.getFilterElement(predicate: "quantity != 0") as! Results<Devices>)[index]
        pageContentViewController.deviceName = data.name
        pageContentViewController.devicePrice = data.price
        pageContentViewController.deviceQuantity = data.quantity
        } else {
            pageContentViewController.deviceName = "No wares in database yet."
            pageContentViewController.devicePrice = 0
            pageContentViewController.deviceQuantity = 0
        }
        pageContentViewController.pageIndex = index
        
        return pageContentViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.tabBarController?.delegate = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    func showViewControllerAtIndex(_ device: String) {
        let index = DatabaseAdapter.baseAdapter.getDeviceIndexByName(device: device)
        self.setViewControllers([getViewControllerAtIndex(index: index)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
          showViewControllerAtIndex(DatabaseAdapter.baseAdapter.lastDevice)
        }
    }
}


