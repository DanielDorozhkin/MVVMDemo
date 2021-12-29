//
//  ImageCollectionViewCell.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 27/12/2021.
//

import UIKit
import Reusable

final class ImageCollectionViewCell: UICollectionViewCell, NibReusable {
    
    //MARK: -Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    private var indexPath      : Int = 0
    private var viewModel      : ImagesViewModel!
    weak var imageViewDelegate : ImageViewProtocol?
    
    //MARK: -Configure
    func configure(_ model: ImagesViewModel, index: Int) {
        showLoadingIndicator()
        
        self.viewModel = model
        self.indexPath = index
        
        longPressRecognize()
        tapPressRecognize()
        
        model.downloadImage({ [weak self] img in
            guard let self = self else { return }
            
            if let img = img {
                self.hideLoadingIndicator()
                self.imageView.image = img
            } else {
                self.imageViewDelegate?.appearError("Connection troubles")
            }
        })
    }
    
    private func showLoadingIndicator() {
        imageView.backgroundColor = .systemGray6
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }
    
    private func hideLoadingIndicator() {
        imageView.backgroundColor = .white
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    //MARK: -Long gesture
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
    //MARK: -Tap gesture
    private func tapPressRecognize() {
        let tapPress = UITapGestureRecognizer(target: self, action: #selector(tapPressed))
        tapPress.cancelsTouchesInView = false
        
        self.addGestureRecognizer(tapPress)
    }
    
    @objc private func tapPressed() {
        viewModel.pushFieldScreen()
    }
}
