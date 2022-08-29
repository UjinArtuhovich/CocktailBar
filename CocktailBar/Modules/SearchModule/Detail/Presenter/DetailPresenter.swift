//
//  DetailPresenter.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 29.08.22.
//

import Foundation

final class DetailPresenter {
    
    // MARK: - Private properties

    private unowned var view: DetailViewProtocol
    private let input: Cocktail
    
    // MARK: - Public properties
    
    var closeDetail: (() -> Void)?
    
    // MARK: - Initializer
    
    init(input: Cocktail,
         view: DetailViewProtocol) {
        self.view = view
        self.input = input
    }
    
    // MARK: - Private methods
    
    private func updateOutput(with output: Cocktail) {
        view.setOutput(with: output)
    }

}

extension DetailPresenter: DetailPresenterProtocol {
    // MARK: - DetailPresenterProtocol methods
    
    func viewLoaded() {
        updateOutput(with: input)
    }
    
    func closeDetailScreen() {
        closeDetail?()
    }
}
