//
//  FilterViewController.swift
//  Sample
//
//  Created by Nikhil Lihla on 05/05/2018.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit

class FilterViewController: ViewController {

    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var sliderView: SliderView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    
    var presenter: FilterPresenter! // injected in wireframe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        populateFilterValues()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func initialSetup() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = Color.viewBackground.color()
        
        self.topContainerView.backgroundColor = Color.navigationBar.color()
        self.cancelButton.addTarget(self,
                                    action: #selector(cancelButtonPressed(sender:)),
                                    for: .touchUpInside)
        
        self.filterLabel.textColor = Color.heading.color()
        self.filterLabel.font = Font.headline.font()
        self.filterLabel.textAlignment = .left
        self.filterLabel.text = "Filter"
        
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
        
        self.sliderView.delegate = self
    }
    
    @objc private func cancelButtonPressed(sender: UIButton) {
        self.presenter.handleCancelButtonPressEvent()
    }

    @objc private func resetButtonClicked(sender: UIButton) {
        self.presenter.resetFilters()
        self.populateFilterValues()
    }
    
    @objc private func applyButtonPressed(sender: UIButton) {
        self.presenter.handleApplyButtonPressEvent()
    }
    
    private func populateFilterValues() {
        self.sliderView.populateValues(filterDTO: self.presenter.getFilterDTO())
    }
}

extension FilterViewController: FilterViewAdapter {
    
}

extension FilterViewController: SliderViewDelegate {
    func minPriceValueChanged(value: String) {
        self.presenter.minPriceChanged(price: value)
    }
    
    func maxPriceValueChanged(value: String) {
        self.presenter.maxPriceChanged(price: value)
    }
    
    func wholeSaleValueChanged(value: Bool) {
        self.presenter.wholesalePriceChanged(value: value)
    }
}
