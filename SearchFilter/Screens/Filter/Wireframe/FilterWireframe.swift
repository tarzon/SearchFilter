//
//  FilterWireframe.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

protocol FilterWireframeDelegate: class {
    func filterUpdated(filter: FilterDTO)
}

protocol FilterWireframe {
    func dismissViewController(filter: FilterDTO)
    func dismissViewController()
}

class FilterWireframeImpl: Wireframe, FilterWireframe {
    weak var delegate: FilterWireframeDelegate?
    
    static func showAsRoot(inNavigationController navigationController: UINavigationController,
                           delegate: FilterWireframeDelegate,
                           filterDTO: FilterDTO) -> UINavigationController {
        let wireframe = FilterWireframeImpl(navigationController: navigationController)
        wireframe.delegate = delegate
        let view = FilterViewController.instantiateFromStoryboard()
        let presenter = FilterPresenter(view: view,
                                        wireframe: wireframe,
                                        screenInteractor: InteractorFactory.sharedInstance.filterScreenInteractor(filterDTO: filterDTO))
        view.presenter = presenter
        wireframe.navigationController.viewControllers = [view]
        return wireframe.navigationController
    }
    
    func dismissViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }

    func dismissViewController(filter: FilterDTO) {
        self.navigationController.dismiss(animated: true) {
            self.delegate?.filterUpdated(filter: filter)
        }
    }
}
