//
//  FilterPresenter.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

class FilterPresenter: Presenter {

    private weak var view: FilterViewAdapter?
    private let wireframe: FilterWireframe
    private let screenInteractor: FilterScreenInteractor

    init(view: FilterViewAdapter, wireframe: FilterWireframe, screenInteractor: FilterScreenInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.screenInteractor = screenInteractor
        super.init()
    }

    func handleCancelButtonPressEvent() {
        self.wireframe.dismissViewController()
    }
    
    func handleApplyButtonPressEvent() {
        self.wireframe.dismissViewController(filter: self.screenInteractor.getFilterDTO())
    }
    
    func getFilterDTO() -> FilterDTO {
        return self.screenInteractor.getFilterDTO()
    }
    
    func resetFilters() {
        self.screenInteractor.resetFilters()
    }
    
    func minPriceChanged(price: String) {
        self.screenInteractor.minPriceChanged(price: price)
    }
    
    func maxPriceChanged(price: String) {
        self.screenInteractor.maxPriceChanged(price: price)
    }
    
    func wholesalePriceChanged(value: Bool) {
        self.screenInteractor.wholesalePriceChanged(value: value)
    }
    
    func shopTypeChanged(shopTypes: [ShopType]) {
        self.screenInteractor.shopTypeChanged(shopTypes: shopTypes)
    }
    
    func removeOfficialStore() {
        self.screenInteractor.removeOfficialStore()
    }
    
    func removeGoldMerchant() {
        self.screenInteractor.removeGoldMerchant()
    }
}
