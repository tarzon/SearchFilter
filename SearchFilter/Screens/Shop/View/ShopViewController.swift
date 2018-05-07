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
    
    @IBOutlet weak var tableView: TableView!
    
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
        
        self.tableView.backgroundColor = Color.viewBackground.color()
        self.tableView.register(ShopTableViewCell.self)
        self.tableView.tableFooterView = UIView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    @objc private func cancelButtonPressed(sender: UIButton) {
        self.presenter.handleCancelButtonPressEvent()
    }
    
    @objc private func resetButtonClicked(sender: UIButton) {
        self.presenter.resetFilters()
        self.populateShopValues()
    }
    
    @objc private func applyButtonPressed(sender: UIButton) {
        self.presenter.handleApplyButtonPressEvent()
    }
    
    private func populateShopValues() {
        self.tableView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ShopViewController: ShopViewAdapter {
    func updateView() {
        self.tableView.reloadData()
    }
}

extension ShopViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getTotalShopTypes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShopTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        let shop = self.presenter.getTotalShopTypes()[indexPath.row]
        let selected = self.presenter.checkIfShopIsSelected(shop: shop)
        
        cell.populateCell(shop: shop, selected: selected)
        return cell
    }
}

extension ShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shop = self.presenter.getTotalShopTypes()[indexPath.row]
        let selected = self.presenter.checkIfShopIsSelected(shop: shop)
        
        if selected {
            self.presenter.deleteShop(shop: shop)
        } else {
            self.presenter.addShops(shop: shop)
        }
    }
}
