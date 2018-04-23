//
//  DeviceViewController.swift
//  EasyECommerce
//
//  Created by admin on 12.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class DeviceViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    var currentDevice: Devices?
    var tempName: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    
    let alert = UIAlertController(title: "Saved", message: "Successfully", preferredStyle: .alert)
    let alert2 = UIAlertController(title: "Some fiels are empty", message: "Please, fill", preferredStyle: .alert)
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        nameField.text = ""
        priceField.text = ""
        quantityField.text = ""
        
        if let item = currentDevice {
            nameField.text = item.name
            priceField.text = "\(item.price)"
            quantityField.text = "\(item.quantity)"
        }
        tempName = nameField.text!
        navigationController?.delegate = self
        priceField?.delegate = self
    }
// сохранение элемента
    @objc func addTapped(sender: AnyObject) {
        if tempName == "" { tempName = nameField.text! }
        if (nameField.text! == "") || (priceField.text! == "") || (quantityField.text! == "") {
        self.present(alert2, animated: true, completion: nil)
        } else {
            DatabaseAdapter.baseAdapter.saveElement(device: tempName, name: nameField.text!, price: Double(priceField.text ?? "")!, quantity: Int(quantityField.text!)!)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? BackEndViewController)?.navigationItem.title = "Back-End"
        (viewController as? BackEndViewController)?.tableView.reloadData()
    }
    
    // ограничение диапазона символов для поля цены. Принимаются только цифры с одной точкой, для типа Double
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            } else {
                return false
            }
        }
    }
}
