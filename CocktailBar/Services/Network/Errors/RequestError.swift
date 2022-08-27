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
}
