//
//  ShopScreenInteractor.swift
//  Sample
//
//  Created by Nikhil Lihla on 07/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

protocol ShopScreenInteractor {
    func getShops() -> [ShopType]
    func resetFilters()
}

class ShopScreenInteractorImpl: ShopScreenInteractor {
    private var filterDTO: FilterDTO
    private var shops: [ShopType]!
    
    init(filterDTO: FilterDTO) {
        self.filterDTO = filterDTO
        self.shops = filterDTO.shopType
    }
    
    func getShops() -> [ShopType] {
        return self.shops
    }
    
    func resetFilters() {
        self.shops = self.filterDTO.shopType
    }
    
}
