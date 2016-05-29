//
//  ViewController.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 5/27/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import UIKit
import CoreData

class AdList: UIViewController, UITableViewDelegate, UITableViewDataSource, APIManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let dataManager = APIManager()
    let managedObjectContext : NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var isShowingList : Bool = true
    
    var allAdds = Array<NSManagedObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initiating the dataMagaer object
        dataManager.delegate = self
        dataManager.managedObjectContext = managedObjectContext
        updateData()
        
        //registering the detail cell xib
        tableView.registerNib(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "detailsCell")

        if NSUserDefaults.standardUserDefaults().valueForKey("aspectPreference") == nil {
            
            NSUserDefaults.standardUserDefaults().setBool(isShowingList, forKey: "aspectPreference")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        } else {
            isShowingList = NSUserDefaults.standardUserDefaults().boolForKey("aspectPreference")
            if isShowingList == false {
                segmentedControl.selectedSegmentIndex = 1
            }
        }
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        allAdds = (self.managedObjectContext?.fetchAllObjects(fromEntityWithName: "Ads"))!
        
        if allAdds.count == 0 {
            
            setLoadingView(true, errorOccurred: false)

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Updating the data
    func updateData(){
        dataManager.updateData()
    }

    //MARK: Table View methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ad = allAdds[indexPath.row] as! Ads
        var reuseIdentifier : String
        
        if isShowingList {
            reuseIdentifier = "listCell"
        } else {
            reuseIdentifier = "detailsCell"

        }
         let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! ListCell
        
        cell.shareButon.addTarget(self, action: #selector(shareButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.shareButon.tag = indexPath.row
        cell.adTitle.text = ad.title
        cell.adPostTime.text = ad.created
        cell.tag = indexPath.row
        
        dataManager.getImage(cell.adImage.frame.size, withIdentifier: ad.id! ) {
             (success, image, error, identifier) in
            
            if success {
                cell.adImage.image = image
            } else {
                //put a placeholder image
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showAdDetails", sender: self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAdds.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return isShowingList ? 50 : 200;
    }

    //MARK: APIDelegate methods
    func dataUpdateError() {
        setLoadingView(true, errorOccurred: true)
    }
    
    func dataUpdateSuccess() {
        allAdds = (self.managedObjectContext?.fetchAllObjects(fromEntityWithName: "Ads"))!
        
        if allAdds.count == 0 {
            setLoadingView(true, errorOccurred: false)
        } else {
            setLoadingView(false, errorOccurred: false)
        }
        
        tableView.reloadData()
    }
    
    //MARK: Segmented Control
    
    @IBAction func didSelectSegment(sender: UISegmentedControl) {
        
        isShowingList = sender.selectedSegmentIndex == 0 ? true : false
        
        NSUserDefaults.standardUserDefaults().setBool(isShowingList, forKey: "aspectPreference")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        tableView.reloadData()
    }
    
    //MARK: Sharing options
    
    @IBAction func shareButtonClicked(sender: UIButton) {
        
        let currentAd = (allAdds[sender.tag] as! Ads)
        
        let text = "Wow! what a good deal: \(currentAd.title!)"
        
        if let website = NSURL(string: currentAd.url!) {
            
            let objectsToShare = [text, website]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! AdDetailsController
        controller.ads = self.allAdds as? Array<Ads>
        controller.currentPage = (tableView.indexPathForSelectedRow?.row)!
        
    }
    
    //MARK: NO data view
    
    //MARK: Setting the view for the loading problems
    
    func setLoadingView(visible: Bool, errorOccurred: Bool) {
        
        tableView.viewWithTag(301)?.removeFromSuperview()
        
        if visible {
            
            self.tableView.separatorColor = UIColor.clearColor()
            
            let view = UIView(frame: CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height))
            view.tag = 301
            view.backgroundColor = UIColor.darkGrayColor()
            
            let label = UILabel(frame: CGRectMake(0,0,200,50))
            label.textColor = UIColor.whiteColor()
            label.center = CGPointMake(view.center.x, view.center.y - 50)
            label.textAlignment = NSTextAlignment.Center
            view.addSubview(label)
            
            if errorOccurred {
                
                label.text = "An Error ocurred"
                
                let button = UIButton(frame: CGRectMake(0,0,200,50))
                button.center = CGPointMake(view.center.x, view.center.y)
                button.setTitle("Tap Here to Retry", forState: UIControlState.Normal)
                button.backgroundColor = UIColor.whiteColor()
                button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
                button.addTarget(self, action: #selector(AdList.updateData), forControlEvents: UIControlEvents.TouchUpInside)
                view.addSubview(button)
                
            } else {
                
                label.text = "Loading Data..."
                
                let indicator = UIActivityIndicatorView(frame: CGRectMake(0,0,100,100))
                indicator.center = view.center
                indicator.startAnimating()
                view.addSubview(indicator)
                
            }
            
            
            
            self.tableView.addSubview(view)
            
        }
    }
}

