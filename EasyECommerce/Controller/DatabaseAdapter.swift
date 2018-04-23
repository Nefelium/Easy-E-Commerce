//
//  Database.swift
//  EasyECommerce
//
//  Created by admin on 21.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

protocol AdapterProtocol {
    func deleteElement(device: String)
    func deleteAll()
    func getAllElements() -> Any
    func getFilterElement(predicate: String) -> Any
    func isDBEmpty() -> Bool
    func saveElement(device: String, name: String, price: Double, quantity: Int)
    func buyElement(device: String)
    func getDeviceIndexByName(device: String) -> Int
}

protocol DataBaseDelegate: class {
    func updateData()
}
protocol DataBasePageViewDelegate: class {
    func updatePageView(_ quantity: Int)
}

class DatabaseAdapter: AdapterProtocol {
    
    var lastDevice: String = ""
    
    static let baseAdapter = DatabaseAdapter(adaptee: RealmDataBase.sharedInstance)
    
    private var realmObject: RealmDataBase
    
    init(adaptee: RealmDataBase) {
       realmObject = adaptee
    }
    
    weak var delegate: DataBaseDelegate?
    weak var delegatePageView: DataBasePageViewDelegate?
    
    func deleteElement(device: String) {
        realmObject.realmDeleteElement(device: device)
    }
    
    func deleteAll() {
        realmObject.realmDeleteAll()
    }
    
    func getAllElements() -> Any {
        return realmObject.getDataFromDB()
    }
    
    func getFilterElement(predicate: String) -> Any {
        return realmObject.getFilterData(predicate: predicate)
    }
    
    func isDBEmpty() -> Bool {
        return realmObject.isDBEmpty()
    }
    
    func saveElement(device: String, name: String, price: Double, quantity: Int) {
        realmObject.realmSave(device: device, name: name, price: price, quantity: quantity)
        self.lastDevice = device
        self.delegate?.updateData()
    }
    
    func buyElement(device: String) {
        let quantity = realmObject.realmBuy(device: device)
        self.delegatePageView?.updatePageView(quantity)
        self.delegate?.updateData()
    }
    
    func getDeviceIndexByName(device: String) -> Int {
        return realmObject.getDeviceIndexByName(device: device)
    }
}

