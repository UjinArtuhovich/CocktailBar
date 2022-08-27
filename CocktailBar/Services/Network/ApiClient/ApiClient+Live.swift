//
//  ApiClient+Live.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 25.08.22.
//

import Foundation

extension ApiClient {
    func searchCocktails(with searchInput: String, completion: @escaping ((Result<CocktailsResponce.Cocktails, RequestError>) -> Void)) {
        request(.searchCocktails(searchInput), output: CocktailsResponce.Cocktails.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
