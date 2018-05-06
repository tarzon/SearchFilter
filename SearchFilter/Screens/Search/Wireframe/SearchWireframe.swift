//
//  SearchWireframe.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

protocol SearchWireframe {
    func gotoFilters(delegate: FilterWireframeDelegate)
}

class SearchWireframeImpl: Wireframe, SearchWireframe {

    static func showAsRoot(inNavigationController navigationController: UINavigationController) -> UINavigationController {
        let wireframe = SearchWireframeImpl(navigationController: navigationController)
        let view = SearchViewController.instantiateFromStoryboard()
        let presenter = SearchPresenter(view: view, wireframe: wireframe, screenInteractor: InteractorFactory.sharedInstance.searchScreenInteractor())
        view.presenter = presenter
        wireframe.navigationController.viewControllers = [view]
        
        return wireframe.navigationController
    }
    
    func gotoFilters(delegate: FilterWireframeDelegate) {
        let filterViewController = FilterWireframeImpl.showAsRoot(inNavigationController: UINavigationController(), delegate: delegate)
        self.navigationController.present(filterViewController, animated: true, completion: nil)
    }
}
