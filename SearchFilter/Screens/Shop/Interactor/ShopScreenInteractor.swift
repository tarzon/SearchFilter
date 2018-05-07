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
    func getTotalShopTypes() -> [ShopType]
    func addShops(shop: ShopType)
    func deleteShop(shop: ShopType)
    func checkIfShopIsSelected(shop: ShopType) -> Bool
}

class ShopScreenInteractorImpl: ShopScreenInteractor {
    private var filterDTO: FilterDTO
    private var shops: [ShopType]!
    private var totalShops: [ShopType]!
    
    init(filterDTO: FilterDTO) {
        self.filterDTO = filterDTO
        
        var newShopTypes: [ShopType] = filterDTO.shopType
        if newShopTypes.contains(.unknown) {
            if let index = newShopTypes.index(where: {$0 == ShopType.unknown}) {
                newShopTypes.remove(at: index)
            }
        }
        
        self.shops = newShopTypes
        self.totalShops = [.goldMerchant, .officialStore]
    }
    
    func getShops() -> [ShopType] {
        return self.shops
    }
    
    func resetFilters() {
        self.shops = self.filterDTO.shopType
    }
    
    func getTotalShopTypes() -> [ShopType] {
        return self.totalShops
    }
    
    func addShops(shop: ShopType) {
        self.shops.append(shop)
    }
    
    func deleteShop(shop: ShopType) {
        var newShopTypes: [ShopType] = self.shops
        if newShopTypes.contains(shop) {
            if let index = newShopTypes.index(where: {$0 == shop}) {
                newShopTypes.remove(at: index)
            }
        }
        
        self.shops = newShopTypes
    }
    
    func checkIfShopIsSelected(shop: ShopType) -> Bool {
        return self.shops.contains(shop)
    }
}
