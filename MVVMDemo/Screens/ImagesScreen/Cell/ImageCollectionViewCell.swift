//
//  ImageCollectionViewCell.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 27/12/2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    //MARK: -OUTLETS
    @IBOutlet private weak var imageView: UIImageView!
    
    private var indexPath : Int = 0
    private var viewModel : ImagesViewModel!
    
    weak var imageViewDelegate : ImageViewProtocol?
    
    //MARK: -CONFIGURE
    func configure(_ model: ImagesViewModel, index: Int) {
        self.viewModel = model
        self.indexPath = index
        
        longPressRecognize()
        
        model.downloadImage({ [weak self] image in
            guard let self = self else { return }
            
            self.imageView.image = image
        })
    }
    
    private func longPressRecognize() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteCell(gestureReconizer:)))
        longPress.cancelsTouchesInView = false
        
        self.addGestureRecognizer(longPress)
    }
    
    @objc private func deleteCell(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state == .ended {
            indexUpdate()
            imageViewDelegate?.deleteCellOn(indexPath)
        }
    }
    
    //In case cells before the last one have been deleted
    private func indexUpdate() {
        let itemsCount = viewModel.imagesCount - 1
        if indexPath > itemsCount {
            indexPath = itemsCount
        }
    }
}
