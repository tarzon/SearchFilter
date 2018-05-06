//
//  SearchScreenInteractor.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

protocol SearchScreenInteractor {
    func fetchProducts(product: String,
                       searchDTO: SearchDTO,
                       completion: @escaping (Bool, Error?) -> Void)
    func getSearchDTO() -> SearchDTO
    func updateSearchDTO(filter: FilterDTO)
    func getProducts() -> [Product]
    func fetchMore(index: Int) -> Bool
}

class SearchScreenInteractorImpl: SearchScreenInteractor {
    private var serviceLayer: ServicesLayer
    private var startIndex: Int = 0
    private var searchDTO: SearchDTO
    private var productArray: [Product] = []
    
    init(serviceLayer: ServicesLayer) {
        self.serviceLayer = serviceLayer
        self.searchDTO = SearchDTO(filter: FilterDTO(minPrice: "0",
                                                     maxPrice: "100000"))
    }
    
    func getSearchDTO() -> SearchDTO {
        return self.searchDTO
    }
    
    func updateSearchDTO(filter: FilterDTO) {
        self.searchDTO = SearchDTO(filter: filter)
    }
    
    func getProducts() -> [Product] {
        return self.productArray
    }
    
    func fetchProducts(product: String,
                       searchDTO: SearchDTO,
                       completion: @escaping (Bool, Error?) -> Void) {
        let productRequestModel = ProductRequestModel(query: product,
                                                      minPrice: searchDTO.filter.minPrice,
                                                      maxPrice: searchDTO.filter.maxPrice,
                                                      wholesale: searchDTO.filter.wholesale,
                                                      official: searchDTO.filter.shopType == ShopType.officialStore ? true: false,
                                                      fshop: "2")
        
        if self.productArray.isEmpty {
            self.startIndex = 0
        } else {
            self.startIndex = self.productArray.count
        }
        
        self.serviceLayer.productSearch(productRequest: productRequestModel,
                                        startIndex: startIndex) { (products, error) in
                                            if let newProducts = products {
                                                self.productArray.append(contentsOf: newProducts)
                                                completion(true, nil)
                                                return
                                            }
                                            
                                            if let loadError = error {
                                                completion(false, loadError)
                                                return
                                            }
        }
    }
    
    func fetchMore(index: Int) -> Bool {
        return self.productArray.count - 2 == index ? true : false
    }
}
