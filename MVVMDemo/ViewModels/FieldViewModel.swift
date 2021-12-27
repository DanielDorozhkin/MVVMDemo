//
//  FieldViewModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import Foundation

class FieldViewModel {
    var tableSource = [String]()
    let requestModel = RequestModel()
    
    weak var fieldDelegate: FieldViewProtocol?
    weak var homeDelegate: HomeViewProtocol?
    
    func sourceRequestFrom(_ text: String?) {
        tableSource.removeAll()
        
        requestModel.requestString = text
        requestConfigure()
    }
    
    func updateHomeScreenButton(index: Int) {
        let number = tableSource[index]
        let text = "\(number)"
        
        homeDelegate?.updateButtonText(text)
    }
    
    private func requestConfigure() {
        if let number = requestModel.validateRequest() {
            configureSourceFrom(number)
            fieldDelegate?.appearSource()
        } else {
            fieldDelegate?.appearError()
        }
    }
    
    private func configureSourceFrom(_ number: Int) {
        for numberItem in Range(0...number - 1) {
            let item = "\(numberItem)"
            tableSource.append(item)
        }
    }
}

//MARK: -PROTOCOLS
protocol FieldViewProtocol: AnyObject {
    func appearSource()
    func appearError()
}

protocol HomeViewProtocol: AnyObject {
    func updateButtonText(_ text: String)
}
