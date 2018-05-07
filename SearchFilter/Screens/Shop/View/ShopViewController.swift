//
//  ShopViewController.swift
//  Sample
//
//  Created by Nikhil Lihla on 07/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class ShopViewController: ViewController {
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    
    var presenter: ShopPresenter! // injected in wireframe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        populateShopValues()
    }
    
    private func initialSetup() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = Color.viewBackground.color()
        
        self.topContainerView.backgroundColor = Color.navigationBar.color()
        self.cancelButton.addTarget(self,
                                    action: #selector(cancelButtonPressed(sender:)),
                                    for: .touchUpInside)
        
        self.shopLabel.textColor = Color.heading.color()
        self.shopLabel.font = Font.headline.font()
        self.shopLabel.textAlignment = .left
        self.shopLabel.text = "Shop"
        
        self.resetButton.setTitle("Reset", for: .normal)
        self.resetButton.setTitleColor(Color.buttonBackground.color(), for: .normal)
        self.resetButton.addTarget(self,
                                   action: #selector(resetButtonClicked(sender:)),
                                   for: .touchUpInside)
        
        self.bottomContainerView.backgroundColor = Color.buttonBackground.color()
        self.applyButton.backgroundColor = Color.buttonBackground.color()
        self.applyButton.setTitle("Apply", for: .normal)
        self.applyButton.setTitleColor(Color.cellBackground.color(),
                                       for: .normal)
        self.applyButton.addTarget(self,
                                   action: #selector(applyButtonPressed(sender:)),
                                   for: .touchUpInside)
    }

    @objc private func cancelButtonPressed(sender: UIButton) {
        self.presenter.handleCancelButtonPressEvent()
    }
    
    @objc private func resetButtonClicked(sender: UIButton) {
        self.presenter.resetFilters()
//        self.populateFilterValues()
    }
    
    @objc private func applyButtonPressed(sender: UIButton) {
        self.presenter.handleApplyButtonPressEvent()
    }
    
    private func populateShopValues() {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ShopViewController: ShopViewAdapter {
    
}
