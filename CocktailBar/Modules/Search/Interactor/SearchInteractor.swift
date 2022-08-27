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
    
    // MARK: - Public properties
    
    weak var presenter: SearchPresenterProtocol?
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}

// MARK: - SearchInteractorProtocol methods

extension SearchInteractor: SearchInteractorProtocol {
    func search(with searchInput: String) {
        guard let presenter = presenter else { return }

        presenter.showLoading()
        
        apiClient.searchCocktails(with: searchInput) { result in
            presenter.hideLoading()
            
            switch result {
            case let .success(responce):
                print(responce)
                
            case let .failure(error):
                presenter.showError(error: error)
            }
        }
    }
}
