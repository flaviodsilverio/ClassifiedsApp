//
//  AdList.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 5/27/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import UIKit

class AdDetailsController: UIViewController, UIPageViewControllerDataSource {

    var ads : Array<Ads>?
    var currentPage : Int = 0
    var pageViewController : UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create page view controller
        pageViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController)
        pageViewController!.dataSource = self;
        
        let startingViewController = self.loadViewControllerAtIndex(currentPage) as! AdDetails
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction:UIPageViewControllerNavigationDirection.Forward, animated:false, completion:nil)
        
        // Change the size of page view controller
        pageViewController!.view.frame = self.view.frame
        
        self.addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAd(sender: AnyObject) {
        
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if currentPage < (ads?.count)! - 1 {
            
            currentPage += 1
            return loadViewControllerAtIndex(currentPage)

        } else {
            
            return nil
            
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if currentPage > 0 {
            
            currentPage -= 1
            return loadViewControllerAtIndex(currentPage)

        } else {
            
            return nil
            
        }
        
    }
    
    func loadViewControllerAtIndex(index: Int) -> UIViewController{
    
        let adDetails = self.storyboard!.instantiateViewControllerWithIdentifier("AdDetails") as! AdDetails
        adDetails.currentAd = ads![index]
        adDetails.pageIndex = index
        return adDetails
    
    }
    

}
