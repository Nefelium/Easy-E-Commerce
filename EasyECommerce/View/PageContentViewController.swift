//
//  PageContentViewController.swift
//  EasyECommerce
//
//  Created by admin on 13.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController, DataBasePageViewDelegate {

    var pageIndex: Int = 0
    var deviceName: String = ""
    var devicePrice: Double = 0.0
    var deviceQuantity = 0
    
    let alert = UIAlertController(title: "Bought", message: "Successfully", preferredStyle: .alert)
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBAction func buyButton(_ sender: Any) {
        DatabaseAdapter.baseAdapter.buyElement(device: nameLabel.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = deviceName
        priceLabel.text = "Price: \(devicePrice)"
        quantityLabel.text = "Available: \(deviceQuantity) pcs."
        DatabaseAdapter.baseAdapter.delegatePageView = self
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }

    func updatePageView(_ quantity: Int) {
        if quantity > 0 {
        quantityLabel.text = "Available: \(quantity-1) pcs."
        self.present(alert, animated: true, completion: nil)
        } else { quantityLabel.text = "Available: 0 pcs." }
    }
}
