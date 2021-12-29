//
//  NumbersViewModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 29/12/2021.
//

import Foundation

final class NumbersViewModel: FieldViewModelProtocol {
    var itemsSource: [String] = []
    
    weak var fieldDelegate: FieldViewProtocol?
    weak var coordinator:   MainCoordinator?
    
    private let requestModel = RequestModel()
    
    var fieldRequestString : String? {
        return requestModel.requestString
    }
    
    func request(_ text: String?) {
        itemsSource.removeAll()
        
        requestModel.requestString = text
        requestConfigure()
    }
    
    private func requestConfigure() {
        if let number = requestModel.validateRequest() {
            requestFor(number)
            fieldDelegate?.sourceState()
        } else {
            fieldDelegate?.errorState("Request must be number and greater then 0")
        }
    }
    
    private func requestFor(_ number: Int) {
        for numberItem in Range(0...number - 1) {
            let item = "\(numberItem)"
            itemsSource.append(item)
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return itemsSource.count
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let text = getNumberStringItem(index: indexPath.row)
        coordinator?.presentHomeScreen(passTitle: nil, goTitle: text)
    }
    
    private func getNumberStringItem(index: Int) -> String {
        let number = itemsSource[index]
        let text   = "\(number)"
        
        return text
    }
}
