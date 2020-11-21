//
//  NSManagedObjectContextExtension.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func saveContext(completition: (() -> Void)? = nil) {
        if hasChanges {
            do {
                try save()
                completition?()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearData(in entity: NSManagedObject.Type) throws {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
        let objects = try fetch(deleteFetch) as! [NSManagedObject]
        objects.forEach { delete($0) }
    }
}
