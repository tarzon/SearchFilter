//
//  APIClient.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import Alamofire

protocol ApiClient {
    func sendRequest(apiRequest: ApiRequest,
                     completion: @escaping(DefaultDataResponse?, Error?) -> Void)
}

class ApiClientImpl: ApiClient {
    fileprivate let baseUrl: URL?
    fileprivate let alamofireManager: Alamofire.SessionManager
    
    init (baseURL: URL?, allowCaching: Bool? = false) {
        self.baseUrl = baseURL
        self.alamofireManager = Alamofire.SessionManager.default
        
        if !allowCaching! {
            self.alamofireManager.session.configuration.urlCache?.diskCapacity = 0
            self.alamofireManager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        }
        else {
            self.alamofireManager.session.configuration.urlCache?.diskCapacity = 10 * 1024 * 1024 // 10 MB of cache
            self.alamofireManager.session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        }
    }
    
    func sendRequest(apiRequest: ApiRequest,
                     completion: @escaping (DefaultDataResponse?, Error?) -> Void) {
        let request = self.alamofireManager.request(self.requestUrl(apiRequest),
                                                    method: apiRequest.method.translate(),
                                                    parameters: apiRequest.parameters,
                                                    encoding: apiRequest.parametersEncoding.translate(),
                                                    headers: apiRequest.headers)
        
        request.response { (defaultResponse) in
            completion(defaultResponse, defaultResponse.error)
        }
    }
    
    fileprivate func requestUrl(_ apiRequest: ApiRequest) -> URL {
        if baseUrl == nil {
            return URL(string: apiRequest.endpoint!)!
        }
        else {
            let finalUrlString = baseUrl?.absoluteString.appending(apiRequest.endpoint!)
            return URL(string: finalUrlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        }
    }
}
