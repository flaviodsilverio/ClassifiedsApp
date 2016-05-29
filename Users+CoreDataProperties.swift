//
//  Users+CoreDataProperties.swift
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

extension Users {

    @NSManaged var id: String?
    @NSManaged var numeric_id: NSNumber?
    @NSManaged var alias: String?
    @NSManaged var name: String?
    @NSManaged var ads: NSSet?
    @NSManaged var location: NSManagedObject?

}
