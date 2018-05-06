//
//  Wholesale.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import ObjectMapper

class WholesalePrice: Mappable {
    enum MappingParameters {
        static let minCount = "count_min"
        static let maxCount = "count_max"
        static let price = "price"
    }
    
    var minCount: Int?
    var maxCount: Int?
    var price: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        minCount <- map[MappingParameters.minCount]
        maxCount <- map[MappingParameters.maxCount]
        price <- map[MappingParameters.price]
    }
}
