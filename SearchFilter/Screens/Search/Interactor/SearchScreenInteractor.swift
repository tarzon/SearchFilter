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
    func makeFreshSearch(completion: @escaping (Bool, Error?) -> Void)
}

class SearchScreenInteractorImpl: SearchScreenInteractor {
    private var serviceLayer: ServicesLayer
    private var startIndex: Int = 0
    private var searchString: String = ""
    private var searchDTO: SearchDTO
    private var productArray: [Product] = []
    private var isNewSearch: Bool = false
    
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
        self.searchString = product
        
        var isOfficial: Bool = false
        for shopType in searchDTO.filter.shopType {
            if shopType == .officialStore {
                isOfficial = true
                return
            }
        }
        
        let productRequestModel = ProductRequestModel(query: product,
                                                      minPrice: searchDTO.filter.minPrice,
                                                      maxPrice: searchDTO.filter.maxPrice,
                                                      wholesale: searchDTO.filter.wholesale,
                                                      official: isOfficial,
                                                      fshop: "2")
        
        if self.productArray.isEmpty {
            self.startIndex = 0
        } else {
            self.startIndex = self.productArray.count
        }
        
        self.serviceLayer.productSearch(productRequest: productRequestModel,
                                        startIndex: startIndex) { (products, error) in
                                            if let newProducts = products {
                                                if self.isNewSearch {
                                                    self.isNewSearch = !self.isNewSearch
                                                    self.productArray.removeAll()
                                                }
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
        return self.productArray.count - 1 == index ? true : false
    }
    
    func makeFreshSearch(completion: @escaping (Bool, Error?) -> Void) {
        self.isNewSearch = true
        self.fetchProducts(product: self.searchString,
                           searchDTO: self.searchDTO,
                           completion: completion)
    }
}
