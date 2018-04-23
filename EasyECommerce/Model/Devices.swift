//
//  Devices.swift
//  EasyECommerce
//
//  Created by admin on 11.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class Devices: Object {
    @objc dynamic var name = ""
    @objc dynamic var price = 0.0
    @objc dynamic var quantity = 0
    
    convenience init(name: String, price: Double, quantity: Int) {
        self.init()
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

