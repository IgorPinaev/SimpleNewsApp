//
//  FetchedResultsService.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 21.11.2020.
//

import Foundation
import CoreData

class FetchedResultsService<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    let frc: NSFetchedResultsController<T>
    
    init(delegate: NSFetchedResultsControllerDelegate, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor] = []) {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataService.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        frc.delegate = delegate
        
        do {
            try frc.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
