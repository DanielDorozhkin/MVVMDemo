//
//  ImagesViewController.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 27/12/2021.
//

import UIKit

class ImagesViewController: UIViewController {
    
    //MARK: -OUTLETS
    @IBOutlet private weak var imagesCollectionView: UICollectionView!
    
    private let imageViewModel : ImagesViewModel
    
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
        
        VCConfigure()
    }
    
    //MARK: -VC CONFIGURE
    private func VCConfigure() {
        collectionConfigure()
    }
    
    private func collectionConfigure() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        imagesCollectionView.register(nib, forCellWithReuseIdentifier: "imageCell")
    }
    
    //MARK: -UI UPDATE
    private func cellAnimation(_ indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            
            if let cell = self.imagesCollectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
                cell.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }
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
        guard let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
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
