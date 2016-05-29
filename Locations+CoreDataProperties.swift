//
//  Locations+CoreDataProperties.swift
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

extension Locations {

    @NSManaged var lat: NSNumber?
    @NSManaged var long: NSNumber?
    @NSManaged var name: String?
    @NSManaged var id: String?
    @NSManaged var user: Users?

}
