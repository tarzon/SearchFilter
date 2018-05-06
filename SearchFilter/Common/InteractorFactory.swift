//
//  InteractorFactory.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation

class InteractorFactory {
    static let sharedInstance = InteractorFactory()
    
    func serviceLayer() -> ServicesLayer {
        return ServicesLayerImpl()
    }
    
    func searchScreenInteractor() -> SearchScreenInteractor {
        return SearchScreenInteractorImpl(serviceLayer: serviceLayer())
    }
    
    func filterScreenInteractor() -> FilterScreenInteractor {
        return FilterScreenInteractorImpl()
    }
}
