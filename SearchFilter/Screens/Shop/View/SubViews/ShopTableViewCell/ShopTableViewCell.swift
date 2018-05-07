//
//  ShopTableViewCell.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 07/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class ShopTableViewCell: TableViewCell, NibLoadableView, ReusableView {
    @IBOutlet weak var checkUncheckImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.title.textColor = Color.title.color()
        self.title.font = Font.title.font()
        self.title.numberOfLines = 1
        self.title.textAlignment = .left
    }
    
    func populateCell(shop: ShopType, selected: Bool) {
        self.title.text = shop.string()
        
       if selected {
           self.checkUncheckImageView.image = UIImage(named: "checkedCheckbox")
       } else {
           self.checkUncheckImageView.image = UIImage(named: "unCheckbox")
       }
    }
}
