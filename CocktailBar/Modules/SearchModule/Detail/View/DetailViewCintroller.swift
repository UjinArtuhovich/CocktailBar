//
//  DetailViewCintroller.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailViewCintroller: UIViewController {
    // MARK: - Private properties
    
    private var titleLabel: UILabel!
    private var imageView: UIImageView!
    
    // MARK: - Public properties
    
    var presenter: DetailPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupItems()
    }
}

private extension DetailViewCintroller {
    // MARK: - Private methods
    
    func setupUI() {
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        
        view.addSubview(blurEffectView)
        
        let titleBackgroundView = UIView()
        titleBackgroundView.backgroundColor = .white
        
        view.addSubview(titleBackgroundView)
        
        titleBackgroundView.snp.makeConstraints { make in
            make.leading.centerX.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        
        titleLabel = .init()
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        
        titleBackgroundView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
        }
        
        imageView = .init()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.centerX.equalToSuperview()
            make.bottom.equalTo(titleBackgroundView.snp.top)
            make.height.equalToSuperview().dividedBy(3)
        }
        
        let gestureRecognizerView = UIView()
        
        view.addSubview(gestureRecognizerView)
        
        gestureRecognizerView.snp.makeConstraints { make in
            make.leading.centerX.top.equalToSuperview()
            make.bottom.equalTo(imageView.snp.top)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        
        gestureRecognizerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupItems() {
        guard let presenter = presenter else { return }
        
        presenter.viewLoaded()
    }
    
    // MARK: - objc methods
    
    @objc func didTapView() {
        guard let presenter = presenter else { return }

        presenter.closeDetailScreen()
    }
}

// MARK: - DetailViewProtocol

extension DetailViewCintroller: DetailViewProtocol {
    func setOutput(with output: Cocktail) {
        titleLabel.text = output.title
        
        guard let imageUrl = URL(string: output.imageUrl) else { return }
        
        imageView.kf.setImage(with: imageUrl)
    }
}
