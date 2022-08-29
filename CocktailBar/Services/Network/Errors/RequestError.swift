//
//  RequestError.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 25.08.22.
//

import Foundation

enum RequestError: Error {
    case decodeError
    case serializationError
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .decodeError:
            return "There was an error. Try again"
        case .invalidResponse:
            return "Error with internet connection"
        case .serializationError:
            return "There was an error. Try again"
        }
    }
}
