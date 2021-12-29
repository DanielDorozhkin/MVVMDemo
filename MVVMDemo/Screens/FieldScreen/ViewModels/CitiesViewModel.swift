//
//  CitiesViewModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 29/12/2021.
//

import Foundation

class CitiesViewModel: FieldViewModelProtocol {
    var itemsSource: [String] = []
    
    weak var fieldDelegate: FieldViewProtocol?
    weak var coordinator:   MainCoordinator?
    
    private let network =   NetworkService.shared
    
    func request(_ text: String?) {
        guard let text = text else { return }
        itemsSource.removeAll()
        
        network.searchCity(text) { [weak self] citiesArray in
            guard let self = self else { return }
            
            citiesArray.forEach({
                self.itemsSource.append($0.name)
            })
            self.fieldDelegate?.sourceState()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return itemsSource.count
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let city = itemsSource[indexPath.row]
        
        coordinator?.presentHomeScreen(passTitle: city, goTitle: nil)
    }
}
