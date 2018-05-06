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
    
    func shopTypeChanged(shopTypes: [ShopType]) {
        self.shopType = shopTypes
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
