//
//  CocktailCell.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 28.08.22.
//

import Foundation
import UIKit

final class CocktailCell: UICollectionViewCell {
    // MARK: - Private properties
    
    private var titleLabel: UILabel!
    
    // MARK: - Public properties
    
    var input: Cocktail? {
        didSet {
            guard let cocktail = input else { return }
            
            titleLabel.text = cocktail.title
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CocktailCell {
    // MARK: - Private methods
    
    func commonInit() {
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        
        titleLabel = .init()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
