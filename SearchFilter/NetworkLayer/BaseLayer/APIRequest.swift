//
//  APIRequest.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import Alamofire

typealias ApiBodyParams = [String: AnyObject]
typealias ApiRequestHeaders = [String: String]

enum ApiReqeustMethod {
    case get
    case post
    
    func translate() -> Alamofire.HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}

enum ApiParametersEncoding {
    case json
    case url
    
    func translate() -> Alamofire.ParameterEncoding {
        switch self {
        case .json:
            return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
}

protocol ApiRequest {
    var endpoint: String? { get }
    var method: ApiReqeustMethod { get }
    var parametersEncoding: ApiParametersEncoding { get }
    var parameters: ApiBodyParams? { get }
    var headers: ApiRequestHeaders? { get }
}

class ApiRequestImpl<T>: ApiRequest {
    open let apiClient: ApiClient
    open var endpoint: String?
    open let method: ApiReqeustMethod
    open let parametersEncoding: ApiParametersEncoding
    var netQueue:DispatchQueue
    
    class var syncQueue:DispatchQueue {
        let qosClass = DispatchQoS.QoSClass.background
        return DispatchQueue.global(qos: qosClass)
    }
    
    var parameters: ApiBodyParams? {
        let params = ApiBodyParams()
        if params.keys.count == 0 {
            return nil
        }
        else {
            return params
        }
    }
    var headers: ApiRequestHeaders? {
        let headers = ApiRequestHeaders()
        if headers.keys.count == 0 {
            return nil
        }
        else {
            return headers
        }
    }
    
    init(apiClient: ApiClient,
         endpoint: String,
         method: ApiReqeustMethod,
         parametersEnconding: ApiParametersEncoding) {
        self.apiClient = apiClient
        self.endpoint = endpoint
        self.method = method
        self.parametersEncoding = parametersEnconding
        self.netQueue = ApiRequestImpl.syncQueue
    }
    
    func sendRequest(completion: @escaping (T?, Error?) -> Void) {
        apiClient.sendRequest(apiRequest: self) { (defaultResponse, error) in
            if error != nil {
                completion(nil, error)
            }
            self.processResult(response: defaultResponse, completion: completion)
        }
    }
    
    func processResult(response: DefaultDataResponse?,
                       completion: (T?, Error?) -> Void) {
        fatalError("Implement this method in child requests")
    }
}
