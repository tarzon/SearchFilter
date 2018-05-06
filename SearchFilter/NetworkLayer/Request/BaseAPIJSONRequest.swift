//
//  BaseAPIJSONRequest.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

enum ApiError: Error {
    case foundNil
    case jsonSerialization
}

class BaseAPIJSONRequest<T>: ApiRequestImpl<T> {
    override func processResult(response: DefaultDataResponse?,
                                completion: (T?, Error?) -> Void) {
        if  response?.error != nil {
            completion(nil, response?.error)
        }
        
        completion(processData(data: response?.data), response?.error)
    }
    
    func processData(data: Data?) -> T? {
        fatalError("Implement this in SubClass")
    }
    
    //MARK: Helper Methods
    
    func extractArray(data: Data?) throws -> NSArray {
        guard let jsonData = data  else {
            throw ApiError.foundNil
        }
        
        do {
            guard let decodedArray = try JSONSerialization.jsonObject(with: jsonData,
                                                                      options: []) as? NSArray else {
                fatalError("Invalid json format, cannot cast to JSONDictionary")
            }
            return decodedArray
        } catch {
            throw ApiError.jsonSerialization
        }
    }
    
    func extractDictionary(data: Data?) throws -> JSONDictionary {
        guard let jsonData = data  else {
            throw ApiError.foundNil
        }
        
        do {
            guard let decodedDictionary = try JSONSerialization.jsonObject(with: jsonData,
                                                                           options: []) as? JSONDictionary else {
                fatalError("Invalid json format, cannot cast to JSONDictionary")
            }
            return decodedDictionary
        } catch {
            throw ApiError.jsonSerialization
        }
    }
}
