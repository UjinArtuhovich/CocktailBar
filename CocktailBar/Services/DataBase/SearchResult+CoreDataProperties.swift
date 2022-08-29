//
//  SearchResult+CoreDataProperties.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 29.08.22.
//
//

import Foundation
import CoreData


extension SearchResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResult> {
        return NSFetchRequest<SearchResult>(entityName: "SearchResult")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var request: SearchRequest?

}

extension SearchResult : Identifiable {

}
