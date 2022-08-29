//
//  CocktailsResponce.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 25.08.22.
//

import Foundation

enum CocktailsResponce {
    struct Cocktails: Decodable {
        let drinks: [Cocktail]?
    }
    
    struct Cocktail: Decodable {
        let id: String
        let name: String
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id = "idDrink"
            case name = "strDrink"
            case imageUrl = "strDrinkThumb"
        }
    }
}
