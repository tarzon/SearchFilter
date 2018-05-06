//
//  SearchDTO.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//



struct SearchDTO {
    var filter: FilterDTO
    
    init(filter: FilterDTO) {
        self.filter = filter
    }
}

struct ProductDTO {
    var imageUri: String
    var title: String
    var price: String
    
    init(imageUrl: String,
         title: String,
         price: String) {
        self.imageUri = imageUrl
        self.title = title
        self.price = price
    }
}
