//
//  SearchPresenter.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    // MARK: - Private properties
    
    private unowned var view: SearchViewProtocol
    
    // MARK: - Public properties
    
    var interactor: SearchInteractorProtocol?
    
    // MARK: - SearchPresenterProtocol properties
    
    var input: String? {
        didSet {
            guard
                var interactor = interactor,
                let input = input,
                input != oldValue,
                !input.isEmpty
            else { return }
            
            interactor.input = input
        }
    }
    
    
    // MARK: - Initializer
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    // MARK: - Private methods
    
    private func updateOutput(with searchOutput: [Cocktail]) {
        view.setSearchOutput(with: searchOutput)
    }
}

extension SearchPresenter {
    // MARK: - SearchPresenterProtocol methods
    
    var output: [Cocktail] {
        get {
            guard let interactor = interactor else { return [] }
            
            return interactor.output
        }
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func showError(error: RequestError) {
        view.showError(error: "")
    }
    
    func updateOutput() {
        view.setSearchOutput(with: output)
    }
    
    func inputChanged(to newInput: String) {
        input = newInput
    }
}
