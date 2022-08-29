//
//  SearchInteractor.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation
import SwiftUI

final class SearchInteractor: SearchInteractorProtocol {
    // MARK: - Private properties
    
    private var outputData: [Cocktail] = []
    private let apiClient: ApiClient
    private let searchDataBaseManager: SearchDataBaseManager
    private unowned var presenter: SearchPresenterProtocol
    
    // MARK: - SearchInteractorProtocol properties
    
    var input: String? {
        didSet {
            guard let input = input else { return }
            
            search(with: input)
        }
    }
    
    var output: [Cocktail] {
        get {
            return outputData
        }
        set {
            outputData = newValue
        }
    }
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient,
         searchDataBaseManager: SearchDataBaseManager,
         presenter: SearchPresenterProtocol) {
        self.apiClient = apiClient
        self.searchDataBaseManager = searchDataBaseManager
        self.presenter = presenter
    }
}

extension SearchInteractor {
    // MARK: - SearchInteractorProtocol methods
    
    func search(with searchInput: String) {
        presenter.showLoading()
        
        searchDataBaseManager.getSearchResults(by: searchInput) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(responce):
                
                self.presenter.hideLoading()
                
                self.output = responce.map { .init(title: $0.title ?? "", imageUrl: $0.imageUrl ?? "") }
                self.presenter.updateOutput()
                
            case .failure:
                self.searchwithServer(with: searchInput)
            }
        }
    }
    
    func searchwithServer(with searchInput: String) {
        apiClient.searchCocktails(with: searchInput) { [weak self] result in
            guard let self = self else { return }
            
            self.presenter.hideLoading()
            
            switch result {
            case let .success(responce):
                guard let drinks = responce.drinks else {
                    self.presenter.noResults()
                    return
                }

                self.output = drinks.map { .init(title: $0.name, imageUrl: $0.imageUrl) }
                self.presenter.updateOutput()
                self.searchDataBaseManager.createSearchRequest(with: searchInput, with: self.output)
                
            case let .failure(error):
                self.presenter.noResults()
                self.presenter.showError(error: error)
            }
        }
    }
}
