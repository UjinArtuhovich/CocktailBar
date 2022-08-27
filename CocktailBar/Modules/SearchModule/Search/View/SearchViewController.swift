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
        view.backgroundColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        
        view.addGestureRecognizer(tapGestureRecognizer)
        
        activityIndicatorView = .init()
        activityIndicatorView.hidesWhenStopped = true
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.height.equalTo(50)
        }
        
        textField = .init()
        textField.backgroundColor = .white
        textField.placeholder = SearchViewControllerConstants.textFieldPlaceholder
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.layer.shadowOpacity = 0.6
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOffset = .zero
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.delegate = self
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(35)
            make.height.equalTo(30)
        }
    }
    
    @objc func didTapView() {
        hideKeyboard()
    }
    
    @objc func stopEditingTextField(textField: UITextField) {
        guard
            let presenter = presenter,
            let text = textField.text
        else { return }
        
        presenter.inputChanged(to: text)
    }
}

// MARK: - TextField delegate

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(
                withTarget: self,
                selector: #selector(stopEditingTextField),
                object: textField)
        
        perform(#selector(stopEditingTextField),
                with: textField,
                afterDelay: 1)
            return true
    }
}

// MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    func setSearchOutput(with searchOutput: [Cocktail]) {
    }
    
    func showLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    func showError(error: String) {
        //
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
}
