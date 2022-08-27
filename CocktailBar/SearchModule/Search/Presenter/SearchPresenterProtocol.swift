//
//  SearchPresenterProtocol.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(error: RequestError)
}
