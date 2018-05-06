//
//  ShopWireframe.swift
//  Sample
//
//  Created by Nikhil Lihla on 07/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

protocol ShopWireframe {
    
}

class ShopWireframeImpl: Wireframe, ShopWireframe {

    /*static func showAsRoot(inNavigationController navigationController: UINavigationController) {

        let wireframe = ShopWireframeImpl(navigationController: navigationController)
        let view = ShopViewController.instantiateFromStoryboard()
        let presenter = ShopPresenter(view: view, wireframe: wireframe, screenInteractor: InteractorFactory.sharedInstance.shopScreenInteractor())
        view.presenter = presenter
        wireframe.navigationController.viewControllers = [view]

    }*/
        
    /*static func push(navigationController navigationController: UINavigationController, animated: Bool = true) {

        let wireframe = ShopWireframeImpl(navigationController: navigationController)
        let view = ShopViewController.instantiateFromStoryboard()
        let presenter = ShopPresenter(view: view, wireframe: wireframe, screenInteractor: InteractorFactory.sharedInstance.shopScreenInteractor())
        view.presenter = presenter
        wireframe.navigationController.pushViewController(view, animated: animated)

    }*/

}