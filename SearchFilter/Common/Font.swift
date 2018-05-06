//
//  Font.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 06/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import UIKit

enum Font {
    case headline
    case title
    case subtitle
    
    func font() -> UIFont {
        switch self {
        case .headline:
            return UIFont(name: "GillSans-SemiBold", size: 17)!
        case .title:
            return UIFont(name: "GillSans", size: 15)!
        case .subtitle:
            return UIFont(name: "GillSans-Light", size: 13)!
        }
    }
}
