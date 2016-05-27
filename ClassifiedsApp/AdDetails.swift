//
//  AdDetails.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 5/27/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import UIKit

class AdDetails: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    var pageIndex = 0
    var titleText : String?
    var imageFile : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = titleText

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
