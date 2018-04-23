//
//  RealmDataBase.swift
//  EasyECommerce
//
//  Created by admin on 14.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmDataBase: NSObject {
    
    static let sharedInstance = RealmDataBase()
    
    func realmDeleteElement(device: String) {
        let realm = try! Realm()
        let theDevice = realm.objects(Devices.self).filter("name == '\(device)'").first
        try! realm.write {
            realm.delete(theDevice!)
        }
    }
    
    func realmDeleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func isDBEmpty() -> Bool {
        let realm = try! Realm()
        let results =  realm.objects(Devices.self)
        return results.isEmpty
    }
    
    func getFilterData(predicate: String) ->   Results<Devices> { 
        let realm = try! Realm()
        let results =  realm.objects(Devices.self).filter(predicate)
        return results
    }
    
    func getDataFromDB() ->   Results<Devices> {
        let realm = try! Realm()
        let results =  realm.objects(Devices.self)
        return results
    }
    
    func realmSave(device: String, name: String, price: Double, quantity: Int) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                var theDevice = realm.objects(Devices.self).filter("name == '\(device)'").first
                if theDevice != nil {
                try! realm.write {
                    theDevice!.name = name
                    theDevice!.price = price
                    theDevice!.quantity = quantity
                }
                } else {
                  theDevice = Devices(name: name, price: price, quantity: quantity)
                    try! realm.write {
                    realm.add(theDevice!)
                    }
                }
            }
        }
    }
    
    func realmBuy(device: String) -> Int {
        DispatchQueue(label: "background").async {
            autoreleasepool {
        let realm = try! Realm()
        let theDevice = realm.objects(Devices.self).filter("name == '\(device)'").first
                if theDevice != nil {
                if (theDevice?.quantity)! > 0 {
            try! realm.write {
                theDevice?.quantity -= 1
                    }
                }
                }
            }
        }
        let realm = try! Realm()
        let theDevice = realm.objects(Devices.self).filter("name == '\(device)'").first
        if theDevice != nil{
            return (theDevice?.quantity)!
        } else { return 0 }
    }
    
    func getDeviceIndexByName(device: String) -> Int {
        var index = 0
        let realm = try! Realm()
        let theDevice = realm.objects(Devices.self).filter("name == '\(device)' && quantity != 0").first
        if theDevice != nil {
        index = RealmDataBase.sharedInstance.getFilterData(predicate: "quantity != 0").index(matching: "name == '\(device)'")!
        }
        return index
    }
    
}
