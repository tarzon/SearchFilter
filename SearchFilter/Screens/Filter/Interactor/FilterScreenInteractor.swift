//
//  FilterScreenInteractor.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

protocol FilterScreenInteractor {
    func minPriceChanged(price: String)
    func maxPriceChanged(price: String)
    func wholesalePriceChanged(value: Bool)
    func shopTypeChanged(shopTypes: [ShopType])
    func getFilterDTO() -> FilterDTO
    func resetFilters()
    func removeOfficialStore()
    func removeGoldMerchant()
}

class FilterScreenInteractorImpl: FilterScreenInteractor {
    private var minPrice: String!
    private var maxPrice: String!
    private var wholesale: Bool = false
    private var shopType: [ShopType] = [.unknown]
    private var filterDTO: FilterDTO
    
    init(filterDTO: FilterDTO) {
        self.filterDTO = filterDTO
        self.initialInitialisation()
    }
    
    private func initialInitialisation() {
        self.minPrice = self.filterDTO.minPrice
        self.maxPrice = self.filterDTO.maxPrice
        self.wholesale = self.filterDTO.wholesale
        self.shopType = self.filterDTO.shopType
    }
    
    func minPriceChanged(price: String) {
        self.minPrice = price
    }
    
    func maxPriceChanged(price: String) {
        self.maxPrice = price
    }
    
    func wholesalePriceChanged(value: Bool) {
        self.wholesale = value
    }
    
    func removeGoldMerchant() {
        var newShopTypes = self.shopType
        if newShopTypes.contains(.goldMerchant) {
            if let index = newShopTypes.index(where: {$0 == ShopType.goldMerchant}) {
                newShopTypes.remove(at: index)
            }
        }
        
        if newShopTypes.isEmpty {
            newShopTypes = [.unknown]
        }
        
        self.shopType = newShopTypes
    }
    
    func removeOfficialStore() {
        var newShopTypes = self.shopType
        if newShopTypes.contains(.officialStore) {
            if let index = newShopTypes.index(where: {$0 == ShopType.officialStore}) {
                newShopTypes.remove(at: index)
            }
        }
        
        if newShopTypes.isEmpty {
            newShopTypes = [.unknown]
        }
        
        self.shopType = newShopTypes
    }
    
    func shopTypeChanged(shopTypes: [ShopType]) {
        if shopTypes.isEmpty {
            self.shopType = [.unknown]
        } else {
            var newShopTypes = shopTypes
            if newShopTypes.contains(.unknown) && newShopTypes.count > 1 {
                if let index = newShopTypes.index(where: {$0 == ShopType.unknown}) {
                    newShopTypes.remove(at: index)
                }
            }
            
            self.shopType = newShopTypes
        }
    }
    
    func getFilterDTO() -> FilterDTO {
        return FilterDTO(minPrice: self.minPrice,
                         maxPrice: self.maxPrice,
                         wholesale: self.wholesale,
                         shopType: self.shopType)
    }
    
    func resetFilters() {
        self.initialInitialisation()
    }
}
