//
//  Product.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import ObjectMapper

class Product: Mappable {
    enum MappingParameters {
        static let productId = "id"
        static let name = "name"
        static let uri = "uri"
        static let imageUri = "image_uri"
        static let imageUri700 = "image_uri_700"
        static let price = "price"
        static let categoryBreadcrumb = "category_breadcrumb"
        static let shop = "shop"
        static let wholesalePrice = "wholesale_price"
        static let condition = "condition"
        static let preorder = "preorder"
        static let departmentId = "department_id"
        static let rating = "rating"
        static let isFeatured = "is_featured"
        static let countReview = "count_review"
        static let countTalk = "count_talk"
        static let countSold = "count_sold"
        static let labels = "labels"
        static let badges = "badges"
        static let originalPrice = "original_price"
        static let discountExpired = "discount_expired"
        static let discountStart = "discount_start"
        static let discountPercentage = "discount_percentage"
        static let stock = "stock"
    }
    
    var productId: String?
    var name: String?
    var uri: String?
    var imageUri: String?
    var imageUri700: String?
    var price: String?
    var categoryBreadcrumb: String?
    var shop: Shop?
    var wholesalePrice: [WholesalePrice]?
    var condition: Bool = false
    var preorder: Bool = false
    var departmentId: Int?
    var rating: Int?
    var isFeatured: Bool = false
    var countReview: Int?
    var countTalk: Int?
    var countSold: Int?
    var labels: [Label]?
    var badges: [Badges]?
    var originalPrice: String?
    var discountPercentage: Int?
    var stock: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        productId <- map[MappingParameters.productId]
        name <- map[MappingParameters.name]
        uri <- map[MappingParameters.uri]
        imageUri <- map[MappingParameters.imageUri]
        imageUri700 <- map[MappingParameters.imageUri700]
        price <- map[MappingParameters.price]
        categoryBreadcrumb <- map[MappingParameters.categoryBreadcrumb]
        shop <- map[MappingParameters.shop]
        wholesalePrice <- map[MappingParameters.wholesalePrice]
        condition <- map[MappingParameters.condition]
        preorder <- map[MappingParameters.preorder]
        departmentId <- map[MappingParameters.departmentId]
        rating <- map[MappingParameters.rating]
        isFeatured <- map[MappingParameters.isFeatured]
        countReview <- map [MappingParameters.countReview]
        countTalk <- map[MappingParameters.countTalk]
        countSold <- map[MappingParameters.countSold]
        labels <- map[MappingParameters.labels]
        badges <- map[MappingParameters.badges]
        originalPrice <- map[MappingParameters.originalPrice]
        discountPercentage <- map[MappingParameters.discountPercentage]
        stock <- map[MappingParameters.stock]
    }
}
