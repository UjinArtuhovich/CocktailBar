//
//  SearchViewController.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    func setSearchInput(with searchInput: String) {
        //
    }
    
    func setSearchOutput(with searchOutput: [Cocktail]) {
        //
    }
    
    func showLoading() {
        //
    }
    
    func hideLoading() {
        //
    }
    
    func showError(error: RequestError) {
        //
    }
}
