//
//  SliderView.swift
//  SearchFilter
//
//  Created by Nikhil Lihla on 06/05/18.
//  Copyright © 2018 Tokopedia. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol SliderViewDelegate: class {
    func minPriceValueChanged(value: String)
    func maxPriceValueChanged(value: String)
    func wholeSaleValueChanged(value: Bool)
}

class SliderView: LoadableFromXibView {
    @IBOutlet weak var minimumPriceLabel: UILabel!
    @IBOutlet weak var maximumPriceLabel: UILabel!
    @IBOutlet weak var centerSeparatorView: UIView!
    @IBOutlet weak var minimumPriceTextFiled: UITextField!
    @IBOutlet weak var minimumPriceTFBorderView: UIView!
    @IBOutlet weak var maximumPriceTextFiled: UITextField!
    @IBOutlet weak var maxmumPriceTFBorderView: UIView!
    @IBOutlet weak var levelsView: UIView!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var wholesaleLabel: UILabel!
    @IBOutlet weak var wholesaleSwitch: UISwitch!
    
    weak var delegate: SliderViewDelegate?
    
    override func onInit() {
        super.onInit()
        
        self.minimumPriceLabel.textAlignment = .left
        self.minimumPriceLabel.textColor = Color.subHeading.color()
        self.minimumPriceLabel.font = Font.subtitle.font()
        self.minimumPriceLabel.text = "Minimum Price"
        
        self.maximumPriceLabel.textAlignment = .right
        self.maximumPriceLabel.textColor = Color.subHeading.color()
        self.maximumPriceLabel.font = Font.subtitle.font()
        self.maximumPriceLabel.text = "Maximum Price"
        
        self.centerSeparatorView.backgroundColor = Color.subHeading.color()
        
        self.minimumPriceTextFiled.isUserInteractionEnabled = true
        self.minimumPriceTextFiled.textAlignment = .left
        self.minimumPriceTextFiled.textColor = Color.title.color()
        self.minimumPriceTextFiled.delegate = self
        self.minimumPriceTextFiled.backgroundColor = UIColor.clear
        self.minimumPriceTextFiled.keyboardType = .numberPad
        self.minimumPriceTextFiled.font = Font.title.font()
        
        self.minimumPriceTFBorderView.backgroundColor = Color.subHeading.color()
        
        self.maximumPriceTextFiled.isUserInteractionEnabled = true
        self.maximumPriceTextFiled.textAlignment = .right
        self.maximumPriceTextFiled.textColor = Color.title.color()
        self.maximumPriceTextFiled.delegate = self
        self.maximumPriceTextFiled.backgroundColor = UIColor.clear
        self.maximumPriceTextFiled.keyboardType = .numberPad
        self.maximumPriceTextFiled.font = Font.title.font()
        
        self.maxmumPriceTFBorderView.backgroundColor = Color.subHeading.color()
        
        self.wholesaleLabel.textAlignment = .left
        self.wholesaleLabel.textColor = Color.title.color()
        self.wholesaleLabel.font = Font.title.font()
        self.wholesaleLabel.text = "Whole Sale"
        
        self.wholesaleSwitch.tintColor = Color.subHeading.color()
        self.wholesaleSwitch.onTintColor = Color.sliderFill.color()
        self.wholesaleSwitch.isOn = false
        self.wholesaleSwitch.addTarget(self,
                                       action: #selector(wholesaleSwitchTapped(sender:)),
                                       for: .valueChanged)
        
        self.rangeSlider.colorBetweenHandles = Color.sliderFill.color()
        self.rangeSlider.hideLabels = true
        self.rangeSlider.lineHeight = 3
        self.rangeSlider.handleDiameter = 20
        self.rangeSlider.tintColor = Color.subHeading.color()
        self.rangeSlider.handleColor = Color.navigationBar.color()
        self.rangeSlider.handleBorderWidth = 1
        self.rangeSlider.handleBorderColor = Color.sliderFill.color()
        self.rangeSlider.delegate = self
        self.rangeSlider.minValue = CGFloat(0)
        self.rangeSlider.maxValue = CGFloat(1000000)
        self.rangeSlider.minDistance = CGFloat(0)
    }
    
    func populateValues(filterDTO: FilterDTO) {
        self.minimumPriceTextFiled.text = "Rp " + filterDTO.minPrice
        self.maximumPriceTextFiled.text = "Rp " + filterDTO.maxPrice
        self.wholesaleSwitch.isOn = filterDTO.wholesale
        
        self.rangeSlider.selectedMinValue = self.getFloatVlaue(price: filterDTO.minPrice)
        self.rangeSlider.selectedMaxValue = self.getFloatVlaue(price: filterDTO.maxPrice)
        
        self.rangeSlider.layoutSubviews()
        self.rangeSlider.layoutIfNeeded()
    }
    
    private func getFloatVlaue(price: String) -> CGFloat {
        let floatVlaue = (String(price) as NSString).floatValue
        return CGFloat(floatVlaue)
    }
    
    @objc private func wholesaleSwitchTapped(sender: UISwitch) {
        sender.isOn = !self.wholesaleSwitch.isOn
    }
    
    private func checkForValidValues(price: String,
                                     textField: UITextField) -> (Bool, CGFloat) {
        var value: String = ""
        if price.count > 3 {
            let index = price.index( price.endIndex, offsetBy: -(price.count - 3))
            let mySubstring = price.suffix(from: index)
            value = String(mySubstring)
        }
        
        if textField == self.minimumPriceTextFiled {
            let floatVlaue = CGFloat((value as NSString).floatValue)
            if floatVlaue <= self.rangeSlider.selectedMaxValue {
                return (true, floatVlaue)
            }
            
            return (false, floatVlaue)
        }
        
        if textField == self.maximumPriceTextFiled {
            let floatVlaue = CGFloat((value as NSString).floatValue)
            if floatVlaue >= self.rangeSlider.selectedMinValue {
                return (true, floatVlaue)
            }
            
            return (false, floatVlaue)
        }
        
        return (false, 0)
    }
}

extension SliderView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if range.location <= 2 {
            return false
        }
        let newString = NSString(string: textField.text!).replacingCharacters(in: range,
                                                                              with: string)
        let tuple = self.checkForValidValues(price: newString,
                                             textField: textField)
        return tuple.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tuple = checkForValidValues(price: textField.text!,
                                        textField: textField)
        
        if textField == self.minimumPriceTextFiled {
            if tuple.0 {
                self.rangeSlider.selectedMinValue = tuple.1
                self.rangeSlider.layoutSubviews()
                self.rangeSlider.layoutIfNeeded()
                
                self.delegate?.minPriceValueChanged(value: String(describing: tuple.1))
            }
        }
        
        if textField == self.maximumPriceTextFiled {
            if tuple.0 {
                self.rangeSlider.selectedMaxValue = tuple.1
                self.rangeSlider.layoutSubviews()
                self.rangeSlider.layoutIfNeeded()
                
                self.delegate?.maxPriceValueChanged(value: String(describing: tuple.1))
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
}

extension SliderView: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider,
                         didChange minValue: CGFloat,
                         maxValue: CGFloat) {
        self.minimumPriceTextFiled.text = "Rp " + String(describing: Int(minValue))
        self.maximumPriceTextFiled.text = "Rp " + String(describing: Int(maxValue))
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider,
                         stringForMaxValue maxValue: CGFloat) -> String? {
        let value = String(describing: Int(maxValue))
        self.delegate?.maxPriceValueChanged(value: value)
        
        return value
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider,
                         stringForMinValue minValue: CGFloat) -> String? {
        let value = String(describing: Int(minValue))
        self.delegate?.minPriceValueChanged(value: value)
        
        return value
    }
}
