//
//  Color.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    case navigationBar
    case heading
    case viewBackground
    case cellBackground
    case title
    case price
    case buttonBackground
    case sliderFill
    case subHeading
    
    func color() -> UIColor {
        switch self {
        case .navigationBar:
            return getColor(r: 252, g: 252, b: 252)
        case .heading:
            return getColor(r: 23, g: 23, b: 23)
        case .viewBackground:
            return getColor(r: 241, g: 241, b: 241)
        case .cellBackground:
            return getColor(r: 255, g: 255, b: 255)
        case .title:
            return getColor(r: 84, g: 84, b: 84)
        case .price:
            return getColor(r: 224, g: 112, b: 63)
        case .buttonBackground:
            return getColor(r: 100, g: 177, b: 87)
        case .sliderFill:
            return getColor(r: 100, g: 177, b: 87)
        case .subHeading:
            return getColor(r: 159, g: 159, b: 159)
        }
    }
    
    private func getColor(r: CGFloat,
                          g: CGFloat,
                          b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
}


