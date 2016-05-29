//
//  AdDetails.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 5/27/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class AdDetails: UITableViewController, MKMapViewDelegate, MFMailComposeViewControllerDelegate  {

    let dataManager : APIManager = APIManager()
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var imageViews : Array<UIImageView> = Array()
    
    var pageIndex : Int?
    var currentAd : Ads?
    var currentUser : Users?
    var firstLaunch : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        currentUser = currentAd?.user as? Users
        
        titleLabel.text = currentAd?.title
        descriptionText.text = currentAd?.desc
        userLabel.text = currentUser?.name
        priceLabel.text = "X Euros"
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = UIRectEdge.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        centerMap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //this is just to avoid it from loading several times the same images
        if(firstLaunch){
            fillScrollViewImages()
            firstLaunch = false
        }
    }
    
    func fillScrollViewImages(){
        
        imageViews = Array()
        let scrollWidth = self.view.frame.size.width
        
        for i in 0...5{
            
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i) * scrollWidth, 0, scrollWidth, scrollView.frame.size.height))
            scrollView.addSubview(imageView)
            
            dataManager.getImage(scrollView.frame.size, withIdentifier: "", completion: {
                (success, image, error, identifier) in
                
                if success == true {
                    imageView.image = image
                }
                
            })
            
        }
        
        scrollView.contentSize = CGSizeMake(scrollWidth * 5, 0)
        scrollView.scrollEnabled = true
    }

    func centerMap(){
        
        let currentLocation = currentUser?.location as! Locations
        
        var region = MKCoordinateRegion()
        let location = CLLocation(
            latitude: Double(currentLocation.lat!),
            longitude: Double(currentLocation.long!))

        region.center = location.coordinate
        mapView?.setRegion(region, animated: true)
        //zoomMapBy(delta: 20)
    }
    
    func zoomMapBy(delta delta:Double) {
        
        var region : MKCoordinateRegion  = self.mapView.region
        var span : MKCoordinateSpan  = mapView.region.span
        span.latitudeDelta *= delta;
        span.longitudeDelta *= delta;
        region.span=span;
        mapView .setRegion(region, animated: true)
        
    }

    //MARK: Actions
    
    @IBAction func phoneUser(sender: AnyObject) {
        
        let alert = UIAlertController(title: "", message: "Would you like to call 919911991?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
            (action) in
            alert.dismissViewControllerAnimated(true, completion: {})
        })
        
        let okAction = UIAlertAction(title: "Call", style: UIAlertActionStyle.Default, handler: {
            (action) in
            self.callNumber("919911991")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: {})
    }
    
    @IBAction func emailUser(sender: AnyObject) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        }
        
    }
    
    //MARK: Phone call
    
    func callNumber(number: String){
        
        var correctedNumber = String()
        
        for character in number.characters {
            
            switch character {
            case "0","1","2","3","4","5","6","7","8","9":
                
                correctedNumber.append(character)
                
                break
                
            default:
                print("\(character) is an invalid character")
            }
            
        }
        
        let phone = "tel://" + correctedNumber
        let url = NSURL(string: phone)
        UIApplication.sharedApplication().openURL(url!)
        
    }

    // MARK: MFMailComposeViewControllerDelegate
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        //mailComposerVC.setToRecipients([(currentUser?.email)!])
        mailComposerVC.setToRecipients(["flaviodsilverio@gmail.com"])
        return mailComposerVC
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
