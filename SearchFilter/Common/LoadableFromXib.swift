//
//  LoadableFromXib.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 05/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

protocol ReusableView: class { }

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

@IBDesignable class LoadableFromXibView: UIView, NibLoadableView {
    @IBOutlet weak var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
        self.onInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
        self.onInit()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func xibSetup() {
        guard let subView = self.loadViewFromXib()
            else { return }
        self.contentView = subView
        self.addSubview(self.contentView)
        self.contentView.fillSuperview()
    }
    
    private func loadViewFromXib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: type(of: self).nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func onInit() {
    }
    
}
