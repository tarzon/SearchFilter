//
//  ShopTypeView.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 07/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

protocol ShopTypeViewDelegate: class {
    func cancelButtonTapped(sender: UIView)
}

class ShopTypeView: LoadableFromXibView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    weak var delegate: ShopTypeViewDelegate?
    
    override func onInit() {
        self.backgroundColor = Color.cellBackground.color()
        self.layer.borderWidth = 1
        self.layer.borderColor = Color.subHeading.color().cgColor
        self.layer.cornerRadius = self.bounds.size.height/2

        self.titleLabel.textColor = Color.subHeading.color()
        self.titleLabel.font = Font.subtitle.font()
        self.titleLabel.textAlignment = .left
        self.titleLabel.numberOfLines = 1
        
        self.cancelButton.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
        self.cancelButton.layer.borderWidth = 1
        self.cancelButton.layer.borderColor = Color.subHeading.color().cgColor
        self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.height/2
    }
    
    @objc private func cancelButtonTapped(sender: UIButton) {
        self.delegate?.cancelButtonTapped(sender: self)
    }
    
    func populateShopType(shopType: ShopType) {
        self.titleLabel.text = shopType.string()
    }
}
