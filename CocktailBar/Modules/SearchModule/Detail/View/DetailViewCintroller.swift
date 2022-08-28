//
//  DetailViewCintroller.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import UIKit
import SnapKit

final class DetailViewCintroller: UIViewController {
    // MARK: - Private properties
    
    // MARK: - Public properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension DetailViewCintroller {
    // MARK: - Private methods
    
    func setupUI() {
        view.backgroundColor = .white
    }
}
