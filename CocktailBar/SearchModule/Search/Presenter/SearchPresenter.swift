//
//  SearchPresenter.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

final class SearchPresenter {
    // MARK: - Private properties
    
    private unowned var view: SearchViewProtocol
    
    // MARK: - Public properties
    
    var interactor: SearchInteractorProtocol?
    
    // MARK: - Initializer
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
}

// MARK: - SearchPresenterProtocol

extension SearchPresenter: SearchPresenterProtocol {
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func showError(error: RequestError) {
        view.showError(error: error)
    }
}
