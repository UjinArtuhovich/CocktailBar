//
//  SearchInteractorProtocol.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

protocol SearchInteractorProtocol {
    var input: String? { set get }
    var output: [Cocktail] {set get}
    func search(with searchInput: String)
}
