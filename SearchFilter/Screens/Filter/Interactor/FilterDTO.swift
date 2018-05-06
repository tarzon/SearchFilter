//
//  FilterDTO.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

enum ShopType {
    case goldMerchant
    case officialStore
    case unknown
    
    func string() -> String {
        switch self {
        case .goldMerchant:
            return "Gold Merchant"
        case .officialStore:
            return "Offical Store"
        case .unknown:
            return "Unknown"
        }
    }
}

struct FilterDTO {
    var minPrice: String
    var maxPrice: String
    var wholesale: Bool
    var shopType: ShopType
    
    init(minPrice: String, maxPrice: String, wholesale: Bool = false, shopType: ShopType = ShopType.unknown) {
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.wholesale = wholesale
        self.shopType = shopType
    }
}
