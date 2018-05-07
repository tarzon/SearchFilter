//
//  ShopWireframe.swift
//  Sample
//
//  Created by Nikhil Lihla on 07/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

protocol ShopWireframeDelegate: class {
    func shopsUpdated(shops: [ShopType])
}

protocol ShopWireframe {
    func dismissViewController()
    func dismissViewController(shops: [ShopType])
}

class ShopWireframeImpl: Wireframe, ShopWireframe {
    weak var delegate: ShopWireframeDelegate?
    
    static func showAsRoot(navigationController: UINavigationController,
                           shops: [ShopType],
                           delegate: ShopWireframeDelegate) -> UINavigationController {
        let wireframe = ShopWireframeImpl(navigationController: navigationController)
        wireframe.delegate = delegate
        let view = ShopViewController.instantiateFromStoryboard()
        let presenter = ShopPresenter(view: view,
                                      wireframe: wireframe,
                                      screenInteractor: InteractorFactory.sharedInstance.shopScreenInteractor(shops: shops))
        view.presenter = presenter
        wireframe.navigationController.viewControllers = [view]
        return wireframe.navigationController
    }

    func dismissViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func dismissViewController(shops: [ShopType]) {
        self.navigationController.dismiss(animated: true) {
            self.delegate?.shopsUpdated(shops: shops)
        }
    }
}
