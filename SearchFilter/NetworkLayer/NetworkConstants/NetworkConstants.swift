//
//  NetworkConstants.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation

enum BaseUrl {
    static let tokopediaBaseUrl = "https://ace.tokopedia.com/search/v2.5/"
}

enum Endpoints {
    case product
    
    func string() -> String {
        switch self {
        case .product: return "product"
        }
    }
}

enum ProductSearchParameters: String {
    case query = "q"
    case minPrice = "pmin"
    case maxPrice = "pmax"
    case wholesale = "wholesale"
    case official = "official"
    case fshop = "fshop"
    case start = "start"
    case rows = "rows"
}
