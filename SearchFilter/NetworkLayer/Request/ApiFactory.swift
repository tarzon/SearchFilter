//
//  ApiFactory.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation

class ApiFactory {
    static let sharedInstance = ApiFactory()
    
    var apiClient: ApiClient = ApiClientImpl(baseURL: URL(string: BaseUrl.tokopediaBaseUrl))
    
    func getProducts(productRequest: ProductRequestModel,
                      startIndex: Int) -> ProductSearchRequest {
        return ProductSearchRequest(apiClient: apiClient, productRequest: productRequest, startIndex: startIndex)
    }
}
