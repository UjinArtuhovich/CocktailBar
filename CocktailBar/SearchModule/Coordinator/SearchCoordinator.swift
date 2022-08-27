//
//  SearchCoordinator.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

final class SearchCoordinator: BaseCoordinator {
    // MARK: - Private properties
    
    private let apiClient: ApiClient
    private let router: Router
    
    // MARK: - Public properties
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient,
         router: Router) {
        self.router = router
        self.apiClient = apiClient
    }
    
    override func start() {
        showSearchScreen()
    }
    
    // MARK: - Private methods
    
    private func showSearchScreen() {
        let viewController = SearchViewController()
        let presenter = SearchPresenter(view: viewController)
        let interactor = SearchInteractor(apiClient: apiClient, presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
      
        router.setRootModule(viewController)
    }
}
