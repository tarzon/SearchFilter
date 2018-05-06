//
//  ProductSearchRequest.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductSearchRequest: BaseAPIJSONRequest<[Product]> {
    var productRequest: ProductRequestModel
    var start: String?
    let rows = 10
    let kData = "data"
    
    override var parameters: ApiBodyParams {
        let parameterDic = [
            ProductSearchParameters.query.rawValue: productRequest.query as AnyObject,
            ProductSearchParameters.minPrice.rawValue: productRequest.minPrice as AnyObject,
            ProductSearchParameters.maxPrice.rawValue: productRequest.maxPrice as AnyObject,
            ProductSearchParameters.wholesale.rawValue: productRequest.wholesale as AnyObject,
            ProductSearchParameters.official.rawValue: productRequest.official as AnyObject,
            ProductSearchParameters.fshop.rawValue: productRequest.fshop as AnyObject,
            ProductSearchParameters.start.rawValue: start as AnyObject,
            ProductSearchParameters.rows.rawValue: rows as AnyObject
        ]
        return parameterDic
    }
    
    init(apiClient:ApiClient,
         productRequest: ProductRequestModel,
         startIndex: Int) {
        self.productRequest = productRequest
        self.start = String(startIndex)
        
        super.init(apiClient: apiClient,
                   endpoint: Endpoints.product.string(),
                   method: .get,
                   parametersEnconding: .url)
    }
    
    override func processData(data: Data?) -> [Product]? {
        var json: JSONDictionary? = nil
        // Parse json
        do {
            json = try extractDictionary(data: data)
        } catch ApiError.jsonSerialization {
            return nil
        } catch {
            return nil
        }
        
        let dataJson = json![kData]
        let products = Mapper<Product>().mapArray(JSONObject: dataJson)
        return products
    }
}
