//
//  APIManager.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 28/05/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import UIKit
import CoreData

protocol APIManagerDelegate : class {
    func dataUpdateSuccess()
    func dataUpdateError()
}

class APIManager: AnyObject {

    weak var delegate : APIManagerDelegate?
    var managedObjectContext : NSManagedObjectContext?
    
    func getAdsFromRemote(){
    
    }
    
    func updateData(){
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let urlRequest = NSURLRequest(URL: NSURL(string: "https://olx.pt/i2/ads/?json=1&search[category_id]=25")!)
        session.dataTaskWithRequest(urlRequest) {
            [weak self] (data : NSData?, response : NSURLResponse?, error : NSError?)  in
            
            
            if error != nil {
                self?.delegate?.dataUpdateError()
            } else {
                
                if let httpResponse = response as? NSHTTPURLResponse {
                
                    switch httpResponse.statusCode {
                        
                    case 200:
                     
                        do {
                            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                            
                            Ads.insertObjects(jsonData["ads"] as! Array<Dictionary<String,AnyObject>>, inContext: (self?.managedObjectContext)!, withCompletion: {
                                (success, error) in
                                
                                if success == true {
                                    self?.dataUpdateSuccess()
                                } else {
                                    self?.dataUpdateError()
                                }
                                
                            })
                           
                        } catch(let error as NSError){
                            print(error.localizedDescription)
                            self?.dataUpdateError()
                            
                        }
                        
                        break
                    
                    default:
                        self?.delegate?.dataUpdateError()
                        break
                    
                    }
                    
                } else {
                    
                    self?.delegate?.dataUpdateError()

                }

            
            }
            
        }.resume()
    }
    
    func getImage(size: CGSize, withIdentifier identifier: String, completion:((success: Bool, image: UIImage?, error: NSError?, identifier: String) -> ())){
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let urlRequest = NSURLRequest(URL: NSURL(string: "http://lorempixel.com/\(Int(size.width))/\(Int(size.height))")!)
        session.dataTaskWithRequest(urlRequest) {
             (data : NSData?, response : NSURLResponse?, error : NSError?)  in
            
            if error != nil {
            
                completion(success: false, image: nil, error: error, identifier: identifier)

            } else {
            
                if(response as! NSHTTPURLResponse).statusCode == 200 {
  
                    guard let image = UIImage.init(data: data!) else {
                        completion(success: false, image: nil, error: nil, identifier: identifier)
                        return

                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(success: true, image: image, error: error, identifier: identifier)

                    })

                } else {
                
                    completion(success: false, image: nil, error: nil, identifier: identifier)
                    
                }
                
            }
            
            
            }.resume()
    
    }
    
    func dataUpdateSuccess(){
        dispatch_async(dispatch_get_main_queue(), {
            self.delegate?.dataUpdateSuccess()

        })
    }
    
    func dataUpdateError(){
        dispatch_async(dispatch_get_main_queue(), {
            self.delegate?.dataUpdateError()
        })

    }
}
