//
//  SearchDataBaseManager.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 29.08.22.
//

import Foundation
import CoreData

class SearchDataBaseManager {
    // MARK: - Core Data stack
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SearchDataBase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
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
    
    // MARK: - Public methods
    
    func createSearchRequest(with searchRequestTitle: String, with searchResults: [Cocktail]) {
        let searchRequest = SearchRequest(context: viewContext)
        
        searchRequest.title = searchRequestTitle
        
        searchResults.forEach { sr in
            let searchResult = SearchResult(context: viewContext)
            searchResult.title = sr.title
            searchResult.imageUrl = sr.imageUrl
            
            searchRequest.addToResult(searchResult)
        }
        
        saveContext()
    }
    
    func getSearchResults(by searchRequestTitle: String, completion: @escaping ((Result<[SearchResult], Error>) -> Void)) {
        getSearchRequest(by: searchRequestTitle) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(responce):
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: SearchResult.self))
                
                request.predicate = NSPredicate(format: "request = %@", responce)
                
                var fetchedSearchResults: [SearchResult] = []
                
                do {
                    fetchedSearchResults = try self.viewContext.fetch(request) as! [SearchResult]
                } catch let error {
                    completion(.failure(error))
                }
                
                completion(.success(fetchedSearchResults))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func getSearchRequest(by searchRequestTitle: String, completion: @escaping ((Result<SearchRequest, Error>) -> Void)) {
        let request: NSFetchRequest<SearchRequest> = SearchRequest.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", searchRequestTitle)
        
        var fetchedSearchRequests: [SearchRequest] = []
        
        do {
            fetchedSearchRequests = try viewContext.fetch(request)
        } catch let error {
            completion(.failure(error))
        }
        
        guard let fetchedSearchRequest = fetchedSearchRequests.first else {
            completion(.failure(RequestError.serializationError))
            return
        }
        
        completion(.success(fetchedSearchRequest))
    }
}
