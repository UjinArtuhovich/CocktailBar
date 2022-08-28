//
//  CocktailsView.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 28.08.22.
//

import Foundation
import UIKit

final class CocktailsView: UIView {
    // MARK: - Private properties
    
    private var collectionView: UICollectionView!
    
    // MARK: - Public properties
    
    var input: [Cocktail]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CocktailsView {
    // MARK: - Private methods
    
    func commonInit() {
        backgroundColor = .clear
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        collectionViewFlowLayout.minimumLineSpacing = 15
        
        collectionView = .init(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CocktailCell.self, forCellWithReuseIdentifier: SearchViewControllerConstants.cocktailCellReuseId)
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.centerX.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension CocktailsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cocktails = input else { return }
        
        print(cocktails[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cocktails = input else { return 0 }
        
        return cocktails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewControllerConstants.cocktailCellReuseId, for: indexPath) as! CocktailCell
        guard let cocktails = input else { return UICollectionViewCell() }
        
        cell.input = cocktails[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cocktails = input else { return CGSize.zero }
        
        return CGSize(width: cocktails[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 30, height: 30)
    }
}
