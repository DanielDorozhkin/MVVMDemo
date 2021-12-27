//
//  UIViewController+.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import Foundation
import UIKit

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
