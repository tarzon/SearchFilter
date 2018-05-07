//
//  SearchPresenter.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

class SearchPresenter: Presenter {
    private weak var view: SearchViewAdapter?
    private let wireframe: SearchWireframe
    private let screenInteractor: SearchScreenInteractor

    init(view: SearchViewAdapter, wireframe: SearchWireframe, screenInteractor: SearchScreenInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.screenInteractor = screenInteractor
        super.init()
    }

    func getSearchDTO() -> SearchDTO {
        return self.screenInteractor.getSearchDTO()
    }
    
    func fetchProducts(product: String, searchDTO: SearchDTO) {
        self.view?.showActivityIndicator()
        self.screenInteractor.fetchProducts(product: product,
                                            searchDTO: searchDTO) { (fetchSuccessFull, error) in
                                                if fetchSuccessFull {
                                                    self.view?.reloadView()
                                                    self.view?.hideActivityIndicator()
                                                }
                                                
                                                if let loadError = error {
                                                    self.view?.reloadView()
                                                    self.view?.displayError(message: loadError.localizedDescription)
                                                    self.view?.hideActivityIndicator()
                                                }
        }
    }
    
    func gotoFilters() {
        self.wireframe.gotoFilters(delegate: self,
                                   filterDTO: self.screenInteractor.getSearchDTO().filter)
    }
    
    func getProducts() -> [Product] {
        return self.screenInteractor.getProducts()
    }
    
    func fetchMore(index: Int) -> Bool {
        let fetchMore = self.screenInteractor.fetchMore(index: index)
        if fetchMore {
            self.view?.showActivityIndicator()
        }
        
        return fetchMore
    }
}

extension SearchPresenter: FilterWireframeDelegate {
    func filterUpdated(filter: FilterDTO) {
        self.screenInteractor.updateSearchDTO(filter: filter)
        self.view?.showActivityIndicator()
        // reload the data as fresh search
        self.screenInteractor.makeFreshSearch { (fetchSuccessFull, error) in
            if fetchSuccessFull {
                self.view?.reloadView()
                self.view?.hideActivityIndicator()
            }
            
            if let loadError = error {
                self.view?.reloadView()
                self.view?.displayError(message: loadError.localizedDescription)
                self.view?.hideActivityIndicator()
            }
        }
    }
}
