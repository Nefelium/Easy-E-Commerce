//
//  DeviceTableViewCell.swift
//  EasyECommerce
//
//  Created by admin on 15.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var device: Devices? {
        didSet {
            nameLabel.text = device?.name
            quantityLabel.text = "\(device?.quantity ?? 0) pcs."
        }
    }
    
}
