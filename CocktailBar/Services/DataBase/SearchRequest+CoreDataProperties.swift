//
//  SearchRequest+CoreDataProperties.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 29.08.22.
//
//

import Foundation
import CoreData


extension SearchRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchRequest> {
        return NSFetchRequest<SearchRequest>(entityName: "SearchRequest")
    }

    @NSManaged public var title: String?
    @NSManaged public var result: NSSet?

}

// MARK: Generated accessors for result
extension SearchRequest {

    @objc(addResultObject:)
    @NSManaged public func addToResult(_ value: SearchResult)

    @objc(removeResultObject:)
    @NSManaged public func removeFromResult(_ value: SearchResult)

    @objc(addResult:)
    @NSManaged public func addToResult(_ values: NSSet)

    @objc(removeResult:)
    @NSManaged public func removeFromResult(_ values: NSSet)

}

extension SearchRequest : Identifiable {

}
