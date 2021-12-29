//
//  UIViewController+.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import Foundation
import UIKit

//MARK: -Keyboard hidding
extension UIViewController {
    func setKeyboardHiding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hide() {
        self.view.endEditing(true)
    }
}

//MARK: -Alert
extension UIViewController {
    func showAlert(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
