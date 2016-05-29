//
//  Ads+CoreDataProperties.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 28/05/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Ads {

    @NSManaged var desc: String?
    @NSManaged var age: NSNumber?
    @NSManaged var title: String?
    @NSManaged var business: NSNumber?
    @NSManaged var chat_options: String?
    @NSManaged var created: String?
    @NSManaged var has_email: NSNumber?
    @NSManaged var has_phone: NSNumber?
    @NSManaged var header: String?
    @NSManaged var header_type: String?
    @NSManaged var hide_user_ads_button: NSNumber?
    @NSManaged var highlighted: NSNumber?
    @NSManaged var id: String?
    @NSManaged var is_price_negotiable: NSNumber?
    @NSManaged var list_label: String?
    @NSManaged var list_label_ad: String?
    @NSManaged var params: NSObject?
    @NSManaged var top_ad: NSNumber?
    @NSManaged var urgent: NSNumber?
    @NSManaged var url: String?
    @NSManaged var user_ads_url: String?
    @NSManaged var status: String?
    @NSManaged var promotion_section: String?
    @NSManaged var preview_url: String?
    @NSManaged var photos: NSObject?
    @NSManaged var user: NSManagedObject?
    @NSManaged var category: Categories?

}
