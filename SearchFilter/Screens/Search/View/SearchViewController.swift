//
//  SearchViewController.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class SearchViewController: ViewController {
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: ProductCollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var presenter: SearchPresenter! // injected in wireframe

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        fetchProducts()
    }
    
    private func initialSetup() {
        self.view.backgroundColor = Color.viewBackground.color()
        
        self.navigationController?.navigationBar.barTintColor = Color.navigationBar.color()
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: Font.headline.font(),
            NSAttributedStringKey.foregroundColor: Color.heading.color()
        ]
        
        self.collectionView.productCollectionViewDelegate = self
        self.activityIndicator.isHidden = true
        
        self.filterButton.backgroundColor = Color.buttonBackground.color()
        self.filterButton.setTitle("Filter", for: .normal)
        self.filterButton.setTitleColor(Color.cellBackground.color(),
                                        for: .normal)
        self.filterButton.addTarget(self,
                                    action: #selector(filterButtonDidTapped(sender:)),
                                    for: .touchUpInside)
    }
    
    private func fetchProducts() {
        self.presenter.fetchProducts(product: "samsung",
                                     searchDTO: self.presenter.getSearchDTO())
    }
    
    @objc private func filterButtonDidTapped(sender: UIButton) {
        self.presenter.gotoFilters()
    }
}

extension SearchViewController: ProductCollectionViewDelegate {
    func numberOfItemsInSection() -> Int {
        return self.presenter.getProducts().count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func sizeForCollectionViewItem() -> CGSize {
        let width = (self.collectionView.bounds.size.width/2) - (CollectionViewLayout.minimumInteritemSpacing + CollectionViewLayout.leftEdgeInset)
        let height = width + (width * 0.45)
        
        return CGSize(width: width, height: height)
    }
    
    func populateCell(index: Int) -> ProductDTO {
        if self.presenter.fetchMore(index: index) {
            fetchProducts()
        }
        let product = self.presenter.getProducts()[index]
        let productDTO = ProductDTO(imageUrl: product.imageUri!, title: product.name!, price: product.price!)
        
        return productDTO
    }
    
    func didSelectItem(index: Int){
        /* Handle Selection */
    }
}

extension SearchViewController: SearchViewAdapter {
    func reloadView() {
        self.collectionView.reloadData()
    }
    
    func displayError(message: String) {
        /* Handle Error */
    }
    
    func showActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
}
