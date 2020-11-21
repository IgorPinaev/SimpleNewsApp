//
//  CoreDataService.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import Foundation
import CoreData

class CoreDataService {
    static let instance = CoreDataService()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SimpleNewsApp")
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearData(in entity: NSManagedObject.Type) throws {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
        let objects = try context.fetch(deleteFetch) as! [NSManagedObject]
        objects.forEach { context.delete($0) }
        
        saveContext()
    }
}
