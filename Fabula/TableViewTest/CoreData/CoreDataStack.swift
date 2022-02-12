//
//  CoreDataStack.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 08/01/2022.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    // MARK: - Properties
    private let modelName: String
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error.userInfo)")
            }
        }
        return container
    }()
    
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
            print("saveContext of Coredatastack executed")
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
}
