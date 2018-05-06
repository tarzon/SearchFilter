//
//  ServiceLayer.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation

protocol ServicesLayer {
    func productSearch(productRequest: ProductRequestModel, startIndex: Int, completion: @escaping(([Product]?, Error?) -> Void))
}

class ServicesLayerImpl: ServicesLayer {
    let apiFactory = ApiFactory.sharedInstance
    
    init() {}
    
    func productSearch(productRequest: ProductRequestModel, startIndex: Int, completion: @escaping(([Product]?, Error?) -> Void)) {
        let request = self.apiFactory.getProducts(productRequest: productRequest, startIndex: startIndex)
        
        request.sendRequest(completion: completion)
    }
}
