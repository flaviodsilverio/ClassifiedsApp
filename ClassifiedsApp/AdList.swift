//
//  AdList.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 5/27/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import UIKit

class AdList: UIViewController, UIPageViewControllerDataSource {

    var imageList : Array<UIImage>?
    var pageTitles : Array<String>?
    var pageViewController : UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pageTitles = ["1","2","3","4"]
        
        // Create page view controller
        pageViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController)
        pageViewController!.dataSource = self;
        
        let startingViewController = self.loadViewControllerAtIndex(0) as! AdDetails
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction:UIPageViewControllerNavigationDirection.Forward, animated:false, completion:nil)
        
        // Change the size of page view controller
        pageViewController!.view.frame = self.view.bounds
        
        self.addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAd(sender: AnyObject) {
        
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! AdDetails).pageIndex
        
        if index < (pageTitles?.count)! - 1 {
            
            index += 1
            return loadViewControllerAtIndex(index)

        } else {
            
            return nil
            
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! AdDetails).pageIndex
        
        if index > 0 {
            
            index -= 1
            return loadViewControllerAtIndex(index)

        } else {
            
            return nil
            
        }
        
    }
    
    func loadViewControllerAtIndex(index: Int) -> UIViewController{
    
        let adDetails = self.storyboard!.instantiateViewControllerWithIdentifier("AdDetails") as! AdDetails
        adDetails.titleText = pageTitles![index]
        adDetails.pageIndex = index
        return adDetails
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
