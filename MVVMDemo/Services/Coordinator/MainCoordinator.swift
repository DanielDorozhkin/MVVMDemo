//
//  MainCoordinator.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 28/12/2021.
//

import Foundation
import UIKit

final class MainCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewModel = HomeViewModel()
        homeViewModel.coordinator = self
        
        let homeVC = HomeViewController(viewModel: homeViewModel)
        navigationController.pushViewController(homeVC, animated: true)
    }
    
    //MARK: -Home
    func presentHomeScreen(passTitle: String?, goTitle: String?) {
        guard let homeVC = navigationController.viewControllers.first(where: {
            $0 is HomeViewController
        }) as? HomeViewController else { return }
        
        if let passTitle = passTitle {
            homeVC.homeViewModel.updatePassTitle(passTitle)
        }
        else if let goTitle = goTitle {
            homeVC.homeViewModel.updateGoTitle(goTitle)
        }
        
        popToHome(homeVC)
    }
    
    private func popToHome(_ vc: HomeViewController) {
        navigationController.popToViewController(vc, animated: true)
    }
    
    //MARK: -Field
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
    
    //MARK: -Images
    func pushImagesScreen(_ count: Int) {
        let model = ImagesViewModel(number: count)
        model.coordinator = self
        
        let imagesVC = ImagesViewController(viewModel: model)
        navigationController.pushViewController(imagesVC, animated: true)
    }
}
