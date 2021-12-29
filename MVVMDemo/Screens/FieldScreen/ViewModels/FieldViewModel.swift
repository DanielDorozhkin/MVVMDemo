//
//  FieldViewModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 28/12/2021.
//

import Foundation

protocol FieldScreenTableProtocol {
    func numberOfRowsInSection(section: Int) -> Int
    func didSelectRowAt(indexPath: IndexPath)
}

protocol FieldViewModelProtocol: FieldScreenTableProtocol, AnyObject {
    var itemsSource : [String] { get set }
    var coordinator: MainCoordinator? { get set }
    
    var fieldDelegate: FieldViewProtocol? { get set }
    
    func request(_ text: String?)
}

protocol FieldViewProtocol: AnyObject {
    func appearSource()
    func appearError()
}

enum FieldViewState {
    case numbers
    case cities
}
