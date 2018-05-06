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

}