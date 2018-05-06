//
//  FilterViewController.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class FilterViewController: ViewController {

    var presenter: FilterPresenter! // injected in wireframe

}

extension FilterViewController: FilterViewAdapter {
    
}