//
//  Shop.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import ObjectMapper

class Shop: Mappable {
    enum MappingParameters {
        static let shopId = "id"
        static let name = "name"
        static let uri = "uri"
        static let isGold = "is_gold"
        static let rating = "rating"
        static let location = "location"
        static let reputationImage = "reputation_image_uri"
        static let shopLucky = "shop_lucky"
        static let city = "city"
    }
    
    var shopId: String?
    var name: String?
    var uri: String?
    var isGold: Int?
    var rating: Int?
    var location: String?
    var reputationImage: String?
    var shopLucky: String?
    var city: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        shopId <- map[MappingParameters.shopId]
        name <- map[MappingParameters.name]
        uri <- map[MappingParameters.uri]
        isGold <- map[MappingParameters.isGold]
        rating <- map[MappingParameters.rating]
        location <- map[MappingParameters.location]
        reputationImage <- map[MappingParameters.reputationImage]
        shopLucky <- map[MappingParameters.shopLucky]
        city <- map[MappingParameters.city]
    }
}
