//
//  Badges.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import ObjectMapper

class Badges: Mappable {
    enum MappingParameters {
        static let title = "title"
        static let imageUri = "image_url"
    }
    
    var title: String?
    var imageUri: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map[MappingParameters.title]
        imageUri <- map[MappingParameters.imageUri]
    }
}
