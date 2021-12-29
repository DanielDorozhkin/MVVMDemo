//
//  ImagesViewModel.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 27/12/2021.
//

import Foundation
import EzImageLoader
import EzHTTP
import UIKit

final class ImagesViewModel {
    weak var coordinator: MainCoordinator?
    var imagesCount: Int
    
    private let network = NetworkService.shared
    
    init(number: Int) {
        self.imagesCount = number
    }
    
    func pushFieldScreen() {
        coordinator?.pushFieldScreen(.cities)
    }
    
    func downloadImage(_ completion: @escaping (UIImage?) -> Void) {
        network.downloadImage { img in
            completion(img)
        }
    }
}

protocol ImageViewProtocol: AnyObject {
    func deleteCellOn(_ indexPath: Int)
    func appearError(_ text: String)
}
