//
//  Categories+CoreDataProperties.swift
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

extension Categories {

    @NSManaged var id: NSNumber?
    @NSManaged var ads: NSSet?

}
