//
//  Book+CoreDataProperties.swift
//  Books App
//
//  Created by Giovanni Prisco on 29/09/2020.
//
//

import Foundation
import CoreData

extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID
    @NSManaged public var notes: String
    @NSManaged public var progress: Double
    @NSManaged public var title: String
    @NSManaged public var updatedAt: Date?
}

extension Book : Identifiable {

}

