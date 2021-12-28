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
    var imagesCount: Int
    
    init(number: Int) {
        self.imagesCount = number
    }
    
    func downloadImage(_ completion: @escaping (UIImage) -> Void) {
        ImageLoader.get("https://picsum.photos/250") { result in
            if let image = result.image {
                completion(image)
            }
        }
    }
}

protocol ImageViewProtocol: AnyObject {
    func deleteCellOn(_ indexPath: Int)
}
