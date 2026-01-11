//
//  ProgressRepository.swift
//  Nudge
//
//  Created by Kaustubh kailas gade on 10/01/26.
//

import Foundation
internal import CoreData

final class ProgressRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceManager.shared.context) {
        self.context = context
    }

    func fetchCompletions(from start: Date, to end: Date) -> [Completion] {
        let request: NSFetchRequest<Completion> = Completion.fetchRequest()
        request.predicate = NSPredicate(
            format: "completedAt >= %@ AND completedAt <= %@",
            start as NSDate,
            end as NSDate
        )

        do {
            return try context.fetch(request)
        } catch {
            assertionFailure("Failed to fetch completions: \(error)")
            return []
        }
    }
}
