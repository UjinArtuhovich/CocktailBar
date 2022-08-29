//
//  Api.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 25.08.22.
//

import Foundation
import Moya

enum Api: TargetType {
    case searchCocktails(String)
}

extension Api {
    var baseURL: URL {
        URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")!
    }
    
    var path: String {
        switch self {
        case .searchCocktails:
            return "search.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchCocktails:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .searchCocktails(searchInput):
            return .requestParameters(parameters: ["s" : searchInput], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
