//
//  FieldViewModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import Foundation

protocol FieldViewProtocol: AnyObject {
    func appearSource()
    func appearError()
}

class FieldViewModel {
    var tableSource = [String]()
    let requestModel = RequestModel()
    
    weak var fieldDelegate: FieldViewProtocol?
    
    func sourceRequestFrom(_ text: String?) {
        tableSource.removeAll()
        
        requestModel.requestString = text
        requestConfigure()
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
