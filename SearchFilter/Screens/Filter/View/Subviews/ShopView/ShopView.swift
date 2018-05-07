//
//  ShopView.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 07/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

protocol ShopViewDelegate: class {
    func topContainerTapped()
    func goldMerchantCancelTapped()
    func officialStoreCancelTapped()
    func isBothViewHidden(hidden: Bool)
}

class ShopView: LoadableFromXibView {
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goldMerchantView: ShopTypeView!
    @IBOutlet weak var officialStoreView: ShopTypeView!
    @IBOutlet weak var officialStoreLeadingLayoutConstraint: NSLayoutConstraint!
    
    weak var delegate: ShopViewDelegate?
    var isBothViewHidden: Bool = true
    
    override func onInit() {
        super.onInit()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(topContainerTapped))
        self.topContainerView.addGestureRecognizer(tapGesture)
        self.topContainerView.backgroundColor = Color.cellBackground.color()
        
        self.titleLabel.textColor = Color.title.color()
        self.titleLabel.font = Font.title.font()
        self.titleLabel.numberOfLines = 1
        self.titleLabel.text = "Shop Type"
        
        self.goldMerchantView.delegate = self
        self.officialStoreView.delegate = self
    }
    
    func populateView(filterDTO: FilterDTO) {
        let shopType = filterDTO.shopType
        
        if !shopType.isEmpty {
            self.populateShopTypeViews(shopType: shopType)
        } else {
            self.goldMerchantView.isHidden = true
            self.officialStoreView.isHidden = true
            self.isBothViewHidden = true
        }
        
        self.delegate?.isBothViewHidden(hidden: self.isBothViewHidden)
    }
    
    private func populateShopTypeViews(shopType: [ShopType]) {
        switch shopType.count {
        case 1:
            if let shopTypeObject = shopType.first {
                if shopTypeObject == ShopType.goldMerchant {
                    self.officialStoreView.isHidden = true
                    self.goldMerchantView.isHidden = false
                    isBothViewHidden = false
                    
                    self.goldMerchantView.populateShopType(shopType: shopTypeObject)
                    
                } else if shopTypeObject == ShopType.officialStore {
                    self.goldMerchantView.isHidden = true
                    self.officialStoreView.isHidden = false
                    isBothViewHidden = false
                    
                    self.officialStoreLeadingLayoutConstraint.constant = 10
                    
                    self.officialStoreView.populateShopType(shopType: shopTypeObject)
                } else {
                    self.goldMerchantView.isHidden = true
                    self.officialStoreView.isHidden = true
                    isBothViewHidden = true
                }
            }
        case 2:
            for shopTypeObject in shopType {
                if shopTypeObject == ShopType.goldMerchant {
                    self.goldMerchantView.isHidden = false
                    self.goldMerchantView.populateShopType(shopType: shopTypeObject)
                    
                } else if shopTypeObject == ShopType.officialStore {
                    self.officialStoreView.isHidden = false
                    self.officialStoreView.populateShopType(shopType: shopTypeObject)
                    self.officialStoreLeadingLayoutConstraint.constant = 160
                }
                
                self.isBothViewHidden = false
            }
        default:
            self.goldMerchantView.isHidden = true
            self.officialStoreView.isHidden = true
            self.isBothViewHidden = true
        }
    }
    
    @objc private func topContainerTapped() {
        self.delegate?.topContainerTapped()
    }
}

extension ShopView: ShopTypeViewDelegate {
    func cancelButtonTapped(sender: UIView) {
        if sender == self.goldMerchantView {
            self.delegate?.goldMerchantCancelTapped()
        }
        
        if sender == self.officialStoreView {
            self.delegate?.officialStoreCancelTapped()
        }
    }
}
