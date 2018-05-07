//
//  ShopPresenter.swift
//  Sample
//
//  Created by Nikhil Lihla on 07/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

class ShopPresenter: Presenter {

    private weak var view: ShopViewAdapter?
    private let wireframe: ShopWireframe
    private let screenInteractor: ShopScreenInteractor

    init(view: ShopViewAdapter, wireframe: ShopWireframe, screenInteractor: ShopScreenInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.screenInteractor = screenInteractor
        super.init()
    }

    func handleCancelButtonPressEvent() {
        self.wireframe.dismissViewController()
    }
    
    func handleApplyButtonPressEvent() {
        self.wireframe.dismissViewController(shops: self.screenInteractor.getShops())
    }
    
    func getShops() -> [ShopType] {
        return self.screenInteractor.getShops()
    }
    
    func resetFilters() {
        self.screenInteractor.resetFilters()
    }
    
    func getTotalShopTypes() -> [ShopType] {
        return self.screenInteractor.getTotalShopTypes()
    }
    
    func addShops(shop: ShopType) {
        self.screenInteractor.addShops(shop: shop)
        self.view?.updateView()
    }
    
    func deleteShop(shop: ShopType) {
        self.screenInteractor.deleteShop(shop: shop)
        self.view?.updateView()
    }
    
    func checkIfShopIsSelected(shop: ShopType) -> Bool {
        return self.screenInteractor.checkIfShopIsSelected(shop: shop)
    }
}
