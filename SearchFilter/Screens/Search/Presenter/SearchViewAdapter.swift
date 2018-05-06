//
//  SearchViewAdapter.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

protocol SearchViewAdapter: class {
    func reloadView()
    func displayError(message: String)
    func showActivityIndicator()
    func hideActivityIndicator()
}
