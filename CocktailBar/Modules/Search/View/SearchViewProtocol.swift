//
//  SearchViewProtocol.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func setSearchInput(with searchInput: String)
    func setSearchOutput(with searchOutput: [Cocktail])
    func showLoading()
    func hideLoading()
    func showError(error: RequestError)
}
