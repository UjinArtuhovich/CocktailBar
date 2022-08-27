//
//  SearchViewController.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    // MARK: - Private properties
    
    private var activityIndicatorView: UIActivityIndicatorView!
    private var textField: UITextField!
    
    // MARK: - Public properties
    
    var presenter: SearchPresenterProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension SearchViewController {
    // MARK: - Private methods
    
    func setupUI() {
        view.backgroundColor = .red
        
        activityIndicatorView = .init()
        activityIndicatorView.hidesWhenStopped = true
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        textField = .init()
        textField.backgroundColor = .white
        textField.placeholder = SearchViewControllerConstants.textFieldPlaceholder
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
//        textField.bonMotStyle = Constants.inputTextStyle
//        textField.delegate = self
//        textField.addTarget(self, action: #selector(changeInputText), for: .editingChanged)
//        textField.addTarget(self, action: #selector(didBeginEditingInputText), for: .editingDidBegin)
//        textField.addTarget(self, action: #selector(didEndEditingInputText), for: .editingDidEnd)
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(35)
            make.height.equalTo(30)
        }
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
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    func showError(error: RequestError) {
        //
    }
}
