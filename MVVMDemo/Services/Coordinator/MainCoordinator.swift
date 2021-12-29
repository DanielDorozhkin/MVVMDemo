//
//  MainCoordinator.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 28/12/2021.
//

import Foundation
import UIKit

final class MainCoordinator {
    
    let homeViewModel = HomeViewModel()
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pushHomeScreen() {
        homeViewModel.coordinator = self
        let homeVC = HomeViewController(viewModel: homeViewModel)
        
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func pushFieldScreen(_ state: FieldViewState) {
        var model : FieldViewModelProtocol
        switch state {
        case .numbers:
            model = NumbersViewModel()
        case .cities:
            model = CitiesViewModel()
        }
        
        model.coordinator = self
        
        let fieldVC = FieldViewController(viewModel: model)
        navigationController.pushViewController(fieldVC, animated: true)
    }
    
    func pushImagesScreen(_ count: Int) {
        let model = ImagesViewModel(number: count)
        model.coordinator = self
        
        let imagesVC = ImagesViewController(viewModel: model)
        navigationController.pushViewController(imagesVC, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
