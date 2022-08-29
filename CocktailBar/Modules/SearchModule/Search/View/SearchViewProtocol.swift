//
//  SearchViewProtocol.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 27.08.22.
//

import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    func setSearchOutput(with searchOutput: [Cocktail])
    func showLoading()
    func hideLoading()
    func showNoResults()
    func hideKeyboard()
    func keyboardWillShow(height: CGFloat)
    func keyboardWillHide()
    func showError(error: String)
}
