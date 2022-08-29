//
//  SearchPresenter.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    
    // MARK: - Private properties
    
    private var keyboardHeightObserver: KeyboardHeightObserver
    private unowned var view: SearchViewProtocol
    
    // MARK: - Public properties
    
    var interactor: SearchInteractorProtocol?
    var showDetail: ((Cocktail) -> Void)?
    
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
    
    
    var output: [Cocktail] {
        get {
            guard let interactor = interactor else { return [] }
            
            return interactor.output
        }
    }
    
    // MARK: - Initializer
    
    init(keyboardHeightObserver: KeyboardHeightObserver,
         view: SearchViewProtocol) {
        self.keyboardHeightObserver = keyboardHeightObserver
        self.view = view
        
        initializeKeyboard()
    }
    
    // MARK: - Private methods
    
    private func updateOutput(with searchOutput: [Cocktail]) {
        view.setSearchOutput(with: searchOutput)
    }
    
    private func initializeKeyboard() {
        keyboardHeightObserver.heightChangedClosure = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .hide:
                self.view.keyboardWillHide()
                
            case let .show(height):
                self.view.keyboardWillShow(height: height)
            }
        }
    }
}

extension SearchPresenter {
    // MARK: - SearchPresenterProtocol methods
    
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func noResults() {
        view.showNoResults()
    }
    
    func showError(error: RequestError) {
        view.showError(error: error.localizedDescription)
    }
    
    func updateOutput() {
        view.setSearchOutput(with: output)
    }
    
    func inputChanged(to newInput: String) {
        input = newInput
    }
    
    func chooseCocktail(input: Cocktail) {
        showDetail?(input)
    }
}
