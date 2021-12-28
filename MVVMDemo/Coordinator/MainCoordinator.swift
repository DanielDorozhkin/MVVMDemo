//
//  MainCoordinator.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 28/12/2021.
//

import Foundation
import UIKit

class MainCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let homeVC = HomeViewController(viewModel: viewModel)
        homeVC.coordinator = self
        
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    func pushFieldScreen(_ viewModel: HomeViewModel) {
        let fieldVC = FieldViewController(viewModel: viewModel)
        fieldVC.coordinator = self
        
        navigationController.pushViewController(fieldVC, animated: true)
    }
    
    func pushImagesScreen(_ viewModel: ImagesViewModel) {
        let imagesVC = ImagesViewController(viewModel: viewModel)
        imagesVC.coordinator = self
        
        navigationController.pushViewController(imagesVC, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
