//
//  ViewController.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    class func instantiateFromStoryboard() -> Self {
        return self.instantiateFromStoryboard(self)
    }
    
    private class func instantiateFromStoryboard<T>(_ type: T.Type) -> T {
        let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
        
        let storyboard = UIStoryboard(name: name+"Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name)
        return vc as! T
    }
}
