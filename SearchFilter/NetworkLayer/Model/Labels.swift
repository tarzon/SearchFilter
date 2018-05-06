//
//  Labels.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import ObjectMapper

class Label: Mappable {
    enum MappingParameters {
        static let title = "title"
        static let color = "color"
    }
    
    var title: String?
    var color: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        title <- map[MappingParameters.title]
        color <- map[MappingParameters.color]
    }
}
