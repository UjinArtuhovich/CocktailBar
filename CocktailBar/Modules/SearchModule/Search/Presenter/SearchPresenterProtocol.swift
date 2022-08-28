//
//  SearchPresenterProtocol.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    var output: [Cocktail] { get }
    var input: String? { get set }
    func showLoading()
    func hideLoading()
    func noResults()
    func showError(error: RequestError)
    func updateOutput()
    func inputChanged(to newInput: String)
}
