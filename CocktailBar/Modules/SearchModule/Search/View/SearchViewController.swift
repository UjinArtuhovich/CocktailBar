//
//  SearchViewController.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import UIKit
import SnapKit
import Toast

final class SearchViewController: UIViewController {
    // MARK: - Private properties
    
    private var activityIndicatorView: UIActivityIndicatorView!
    private var textField: UITextField!
    private var noResultsLabel: UILabel!
    private var cocktailsView: CocktailsView!
    
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
        
        cocktailsView = .init()
        cocktailsView.isHidden = true
        
        view.addSubview(cocktailsView)
        
        cocktailsView.snp.makeConstraints { make in
            make.centerX.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        let mainView = UIView()
        
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(cocktailsView.snp.bottom)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        
        mainView.addGestureRecognizer(tapGestureRecognizer)
        
        activityIndicatorView = .init()
        activityIndicatorView.hidesWhenStopped = true
        
        mainView.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        noResultsLabel = .init()
        noResultsLabel.text = SearchViewControllerConstants.noResultsText
        
        mainView.addSubview(noResultsLabel)
        
        noResultsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
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
        
        mainView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-150)
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

// MARK: - UITextFieldDelegate

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
        cocktailsView.isHidden = false
        cocktailsView.input = searchOutput
    }
    
    func showLoading() {
        noResultsLabel.isHidden = true
        cocktailsView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    func showNoResults() {
        noResultsLabel.isHidden = false
    }
    
    func keyboardWillShow(height: CGFloat) {
        textField.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-height)
            make.leading.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .layoutSubviews) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide() {
        textField.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-150)
            make.leading.equalToSuperview().offset(35)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .layoutSubviews) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showError(error: String) {
        view.makeToast(error, duration: 3.0, position: .top)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
}
