//
//  ProductCollectionViewCell.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 06/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit
import Nuke

class ProductCollectionViewCell: CollectionViewCell, NibLoadableView, ReusableView {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.backgroundColor = Color.cellBackground.color()
        productImageView.backgroundColor = Color.subHeading.color()
        
        titleLabel.textColor = Color.title.color()
        titleLabel.font = Font.title.font()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        
        priceLabel.textColor = Color.price.color()
        priceLabel.font = Font.title.font()
        priceLabel.textAlignment = .left
        priceLabel.numberOfLines = 1
        priceLabel.lineBreakMode = .byTruncatingTail
    }
    
    func populateCell(productDTO: ProductDTO) {
        titleLabel.text = productDTO.title
        titleLabel.sizeToFit()
        priceLabel.text = productDTO.price
        priceLabel.sizeToFit()
        Manager.shared.loadImage(with: Request(url: URL(string: productDTO.imageUri)!), into: self.productImageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
