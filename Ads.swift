//
//  Ads.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 28/05/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import Foundation
import CoreData


class Ads: NSManagedObject {
    
    class func insertObjects(objects: Array<Dictionary<String,AnyObject>>, inContext context: NSManagedObjectContext, withCompletion completion: (success: Bool?, error: NSError?)->()){
    
        let childContext =        NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        childContext.parentContext = context
        childContext .performBlock({
            
            for object in objects {
                
                let managedObject = childContext.findOrCreateObject(withID: object["id"] as! String, forEntityName: "Ads") as! Ads
                
                managedObject.age = object["age"] as? NSNumber
                managedObject.business          = object["business"] as? Bool
                managedObject.chat_options      = object["chat_options"] as? String
                managedObject.created           = object["created"] as? String
                managedObject.desc              = object["description"] as? String
                managedObject.has_email         = object["has_email"] as? Bool
                managedObject.has_phone         = object["has_phone"] as? Bool
                managedObject.header            = object["header"] as? String
                managedObject.header_type       = object["header_type"] as? String
                managedObject.hide_user_ads_button = object["hide_user_ads_button"] as? Bool
                managedObject.highlighted       = object["highlighted"] as? Bool
                managedObject.is_price_negotiable = object["is_price_negotiable"] as? Bool
                managedObject.list_label        = object["list_label"] as? String
                managedObject.list_label_ad     = object["list_label_ad"] as? String
                managedObject.params            = object["params"] as? String
                managedObject.photos            = object["photos"] as? String
                managedObject.preview_url       = object["preview_url"] as? String
                managedObject.promotion_section = object["promotion_section"] as? String
                managedObject.status            = object["status"] as? String
                managedObject.title = object["title"] as? String
                managedObject.top_ad = object["top_ad"] as? Bool
                managedObject.urgent = object["urgent"] as? Bool
                managedObject.url = object["url"] as? String
                managedObject.user_ads_url = object["user_ads_url"] as? String
                
                let user = childContext.findOrCreateObject(withID: object["user_id"]  as! String, forEntityName: "Users") as! Users
                let location = childContext.findOrCreateObject(withID: object["map_location"] as! String, forEntityName: "Locations") as! Locations
                location.lat = Double(object["map_lat"] as! String)
                location.long = Double(object["map_lon"] as! String)
                
                user.name = object["user_label"] as? String
                user.location = location
                managedObject.user = user
            }
            
            do{
                try childContext.save()
                try childContext.parentContext?.save()
                
                completion(success: true, error: nil)
                
            } catch (let error as NSError){
                
                print(error.localizedDescription)
                
                completion(success: false, error: error)
            }
            
            

        })
    
    }

}
