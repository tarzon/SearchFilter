//
//  ProductRequestModel.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation

struct ProductRequestModel {
    var query: String?
    var minPrice: String?
    var maxPrice: String?
    var wholesale: Bool
    var official: Bool
    var fshop: String?
    
    init(query: String,
         minPrice: String,
         maxPrice: String?,
         wholesale: Bool,
         official: Bool,
         fshop: String?) {
        self.query = query
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.wholesale = wholesale
        self.official = official
        self.fshop = fshop
    }
}
