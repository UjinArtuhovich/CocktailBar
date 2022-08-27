//
//  SearchPresenter.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

final class SearchPresenter {
    // MARK: - Public properties
    
    weak var view: SearchViewProtocol?
}

// MARK: - SearchPresenterProtocol

extension SearchPresenter: SearchPresenterProtocol {
    func showLoading() {
        guard let view = view else { return }

        view.showLoading()
    }
    
    func hideLoading() {
        guard let view = view else { return }

        view.hideLoading()
    }
    
    func showError(error: RequestError) {
        guard let view = view else { return }

        view.showError(error: error)
    }
}
