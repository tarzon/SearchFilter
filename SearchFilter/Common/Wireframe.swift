//
//  Wireframe.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import UIKit

class Wireframe: NSObject {    
    weak var navigationController: UINavigationController!
    
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
