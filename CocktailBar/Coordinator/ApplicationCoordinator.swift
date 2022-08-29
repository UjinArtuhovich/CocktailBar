//
//  ApplicationCoordinator.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Private properties
    
    private let apiClient: ApiClient
    private let searchDataBaseManager: SearchDataBaseManager
    private let keyboardHeightObserver: KeyboardHeightObserver
    private let router: Router
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient,
         searchDataBaseManager: SearchDataBaseManager,
         keyboardHeightObserver: KeyboardHeightObserver,
         router: Router) {
        self.apiClient = apiClient
        self.searchDataBaseManager = searchDataBaseManager
        self.keyboardHeightObserver = keyboardHeightObserver
        self.router = router
    }
    
    override func start() {
        startSearchFlow()
    }
    
    // MARK: - Private methods
    
    private func startSearchFlow() {
        let coordinator = SearchCoordinator(apiClient: apiClient,
                                            searchDataBaseManager: searchDataBaseManager,
                                            keyboardHeightObserver: keyboardHeightObserver,
                                            router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
