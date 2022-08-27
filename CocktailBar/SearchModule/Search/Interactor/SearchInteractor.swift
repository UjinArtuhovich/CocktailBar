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
    private unowned var presenter: SearchPresenterProtocol
    
    // MARK: - SearchInteractorProtocol properties
    
    var input: String? {
        didSet {
            guard let input = input else { return }
            
            search(with: input)
        }
    }
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient,
         presenter: SearchPresenterProtocol) {
        self.apiClient = apiClient
        self.presenter = presenter
    }
}

extension SearchInteractor {
    // MARK: - SearchInteractorProtocol methods
    
    var output: [Cocktail] {
        get {
            return outputData
        }
        set {
            outputData = newValue
        }
    }
    
    func search(with searchInput: String) {
        presenter.showLoading()
        
        apiClient.searchCocktails(with: searchInput) { [weak self] result in
            guard let self = self else { return }
            
            self.presenter.hideLoading()
            
            switch result {
            case let .success(responce):
                guard let drinks = responce.drinks else { return }

                self.output = drinks.map { .init(title: $0.name, image: $0.image) }
                self.presenter.updateOutput()
                
            case let .failure(error):
                self.presenter.showError(error: error)
            }
        }
    }
}
