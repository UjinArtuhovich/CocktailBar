//
//  SearchInteractor.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

final class SearchInteractor {
    // MARK: - Private properties
    
    private let apiClient: ApiClient
    private unowned var presenter: SearchPresenterProtocol
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient,
         presenter: SearchPresenterProtocol) {
        self.apiClient = apiClient
        self.presenter = presenter
    }
}

// MARK: - SearchInteractorProtocol methods

extension SearchInteractor: SearchInteractorProtocol {
    func search(with searchInput: String) {
        presenter.showLoading()
        
        apiClient.searchCocktails(with: searchInput) { [weak self] result in
            guard let self = self else { return }
            
            self.presenter.hideLoading()
            
            switch result {
            case let .success(responce):
                print(responce)
                
            case let .failure(error):
                self.presenter.showError(error: error)
            }
        }
    }
}
