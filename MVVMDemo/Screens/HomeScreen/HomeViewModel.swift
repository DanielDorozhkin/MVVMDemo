//
//  FieldViewModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import Foundation

final class HomeViewModel {
    
    weak var coordinator : MainCoordinator?
    var colorTapCounter  : Int = 0
    
    var goButtonTitle    : String?
    var passButtonTitle  : String?
    
    func pushFieldScreen() {
        coordinator?.pushFieldScreen(.numbers)
    }
    
    func pushImagesScreen() {
        let imagesCount = getCurrentNumber()
        coordinator?.pushImagesScreen(imagesCount)
    }
    
    private func getCurrentNumber() -> Int {
        if let text = goButtonTitle {
            if let num = Int(text) {
                return num
            }
        }
        
        return 0
    }
    
    func updateGoTitle(_ title: String) {
        self.goButtonTitle = title
    }
    
    func updatePassTitle(_ title: String) {
        self.passButtonTitle = title
    }
}
