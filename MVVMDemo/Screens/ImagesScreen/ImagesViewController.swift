//
//  ImagesViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 27/12/2021.
//

import UIKit

final class ImagesViewController: UIViewController {
    
    //MARK: -OUTLETS
    @IBOutlet private weak var imagesCollectionView: UICollectionView!
    
    private let imageViewModel : ImagesViewModel
    weak var coordinator       : MainCoordinator?
    
    //MARK: -INIT
    required init(viewModel: ImagesViewModel) {
        self.imageViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init() {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: -VIEW LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionConfigure()
    }
    
    //MARK: -VC CONFIGURE
    private func collectionConfigure() {
        imagesCollectionView.delegate   = self
        imagesCollectionView.dataSource = self
        
        imagesCollectionView.register(cellType: ImageCollectionViewCell.self)
    }
    
    //MARK: -UI UPDATE
    private func cellAnimation(_ indexPath: IndexPath) {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            guard let self = self else { return }
            
            let cell : ImageCollectionViewCell = self.imagesCollectionView.dequeueReusableCell(for: indexPath)
            cell.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            
        }, completion: { [weak self] _ in
            self?.imagesCollectionView.deleteItems(at: [indexPath])
        })
    }
}

//MARK: -COLLECTION VIEW
extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewModel.imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImageCollectionViewCell = imagesCollectionView.dequeueReusableCell(for: indexPath)
        
        cell.imageViewDelegate = self
        cell.configure(imageViewModel, index: indexPath.row)
        
        return cell
    }
}

//MARK: -IMAGE PROTOCOL
extension ImagesViewController: ImageViewProtocol {
    func deleteCellOn(_ indexPath: Int) {
        let index = IndexPath(item: indexPath, section: 0)
        imageViewModel.imagesCount -= 1
        
        cellAnimation(index)
    }
}
