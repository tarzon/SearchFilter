//
//  ShopScreenInteractor.swift
//  Sample
//
//  Created by Nikhil Lihla on 07/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

protocol ShopScreenInteractor {

}

class ShopScreenInteractorImpl: ShopScreenInteractor {
    private var shops: [ShopType]!
    
    init(shops: [ShopType]) {
        self.shops = shops
    }
    
    
    
}
