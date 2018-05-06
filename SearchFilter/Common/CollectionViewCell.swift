//
//  CollectionViewCell.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 06/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.onInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.onInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.onInit()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.onInit()
    }
    
    func onInit() {
    }
}
