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
    private let keyboardHeightObserver: KeyboardHeightObserver
    private let router: Router
    
    // MARK: - Public properties
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient,
         keyboardHeightObserver: KeyboardHeightObserver,
         router: Router) {
        self.apiClient = apiClient
        self.keyboardHeightObserver = keyboardHeightObserver
        self.router = router
    }
    
    override func start() {
        showSearchScreen()
    }
    
    // MARK: - Private methods
    
    private func showSearchScreen() {
        let viewController = SearchViewController()
        let presenter = SearchPresenter(keyboardHeightObserver: keyboardHeightObserver, view: viewController)
        let interactor = SearchInteractor(apiClient: apiClient, presenter: presenter)
        
        presenter.showDetail = { input in
            self.showDetailScreen(with: input)
        }
        
        viewController.presenter = presenter
        presenter.interactor = interactor
      
        router.setRootModule(viewController)
    }
    
    private func showDetailScreen(with input: Cocktail) {
        let viewController = DetailViewCintroller()
        let presenter = DetailPresenter(input: input, view: viewController)
        
        presenter.closeDetail = {
            self.router.dismissModule()
        }
        
        viewController.presenter = presenter
        
        router.present(viewController, animated: true)
    }
}
