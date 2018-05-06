//
//  CollectionView.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 06/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

enum CollectionViewLayout {
    static let minimumInteritemSpacing = CGFloat(1)
    static let minimumLineSpacing = CGFloat(2)
    static let topEdgeInset = CGFloat(10)
    static let bottomEdgeInset = CGFloat(10)
    static let leftEdgeInset = CGFloat(10)
    static let rightEdgeInset = CGFloat(10)
}

protocol ProductCollectionViewDelegate: class {
    func numberOfItemsInSection() -> Int
    func numberOfSections() -> Int
    func sizeForCollectionViewItem() -> CGSize
    func populateCell(index: Int) -> ProductDTO
    func didSelectItem(index: Int)
}

class ProductCollectionView: CollectionView {
    weak var productCollectionViewDelegate: ProductCollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = Color.viewBackground.color()
        self.register(ProductCollectionViewCell.self)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = CollectionViewLayout.minimumLineSpacing
        flowLayout.minimumInteritemSpacing = CollectionViewLayout.minimumInteritemSpacing
        flowLayout.sectionInset = UIEdgeInsetsMake(CollectionViewLayout.topEdgeInset,
                                                   CollectionViewLayout.leftEdgeInset,
                                                   CollectionViewLayout.bottomEdgeInset,
                                                   CollectionViewLayout.rightEdgeInset)
        
        self.collectionViewLayout = flowLayout
        self.dataSource = self
        self.delegate = self
    }
}

extension ProductCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.productCollectionViewDelegate!.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.productCollectionViewDelegate!.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ProductCollectionViewCell
        
        let productDTO = self.productCollectionViewDelegate?.populateCell(index: indexPath.item)
        cell.populateCell(productDTO: productDTO!)
        return cell
    }
}

extension ProductCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.productCollectionViewDelegate!.sizeForCollectionViewItem()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CollectionViewLayout.topEdgeInset,
                            left: CollectionViewLayout.leftEdgeInset,
                            bottom: CollectionViewLayout.bottomEdgeInset,
                            right: CollectionViewLayout.rightEdgeInset)
    }
}

extension ProductCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.productCollectionViewDelegate?.didSelectItem(index: indexPath.item)
        collectionView.reloadItems(at: [indexPath])
    }
}
