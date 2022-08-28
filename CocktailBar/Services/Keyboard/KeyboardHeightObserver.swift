//
//  KeyboardHeightObserver.swift
//  CocktailBar
//
//  Created by Ujin Artuhovich on 28.08.22.
//

import Foundation
import UIKit

class KeyboardHeightObserver {
    // MARK: - Public methods
    
    var heightChangedClosure: ((KeyboardState) -> Void)?
    
    // MARK: - Initializer

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardHeightObserver.keyboardWillChangeSize(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardHeightObserver.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KeyboardHeightObserver.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension KeyboardHeightObserver {
    // MARK: - Private methods
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        heightChangedClosure?(.show(height: frame.size.height))
    }

    @objc func keyboardWillHide(_: NSNotification) {
        heightChangedClosure?(.hide)
    }

    @objc func keyboardWillChangeSize(_ notification: NSNotification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        heightChangedClosure?(.show(height: frame.size.height))
    }
}

