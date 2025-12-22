//
//  CoreData.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 21/12/25.
//

internal import CoreData
import Foundation

final class PersistenceManager {

    static let shared = PersistenceManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NudgeDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Failed to save context:", error)
        }
    }
}
