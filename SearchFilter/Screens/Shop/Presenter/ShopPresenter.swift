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

}