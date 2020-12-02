//
//  NSManagedObjectContext+Extensions.swift
//  CoffeeOrdering
//
//  Created by Nitin Bhatt on 11/24/20.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let persistenceController = PersistenceController.shared
        return persistenceController.container.viewContext
    }
}
