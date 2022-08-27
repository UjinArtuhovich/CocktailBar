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
    private let router: Router
    
    // MARK: - Initializer
    
    init(apiClient: ApiClient,
         router: Router) {
        self.router = router
        self.apiClient = apiClient
    }
    
    override func start() {
        startSearchFlow()
    }
    
    // MARK: - Private methods
    
    private func startSearchFlow() {
        let coordinator = SearchCoordinator(apiClient: apiClient, router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
