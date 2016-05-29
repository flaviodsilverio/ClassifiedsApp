//
//  Extensions.swift
//  ClassifiedsApp
//
//  Created by Flávio Silvério on 28/05/16.
//  Copyright © 2016 Flavio Silverio. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    func findOrCreateObject(withID ID: String, forEntityName entityName: String) -> NSManagedObject {
    
        //creating the fetch request and predicate
        let fetchRequest = NSFetchRequest(entityName: entityName)
        let predicate = NSPredicate(format: "id == '\(ID)'")
        
        //assigning the predicate and defining the fetch limit
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do{
            let results = try self.executeFetchRequest(fetchRequest)
            
            if results.count == 1 {
                return results.first as! NSManagedObject
            }
        
        } catch (let error as NSError){
            print(error.localizedDescription)
        }
        
        let newObject = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: self)
        newObject.setValue(ID, forKey: "id")
        return newObject
    }
    
    func fetchAllObjects(fromEntityWithName entityName: String) -> Array<NSManagedObject>?{
    
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        do{
            let results = try self.executeFetchRequest(fetchRequest)
            
            if results.count > 0 {
                return results as? Array<NSManagedObject>
            }
            
        } catch (let error as NSError){
            print(error.localizedDescription)
        }

        return []
    }

}
