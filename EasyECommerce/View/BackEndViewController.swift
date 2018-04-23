//
//  ViewController.swift
//  EasyECommerce
//
//  Created by admin on 11.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class BackEndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataBaseDelegate {
    
    var item: Devices?
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addDeviceButton(_ sender: Any) {
        item = nil
        self.performSegue(withIdentifier: "editDeviceSegue", sender: self)
    }
    @IBAction func cancelBack(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DatabaseAdapter.baseAdapter.getAllElements() as! Results<Devices>).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DeviceTableViewCell
        let device: Devices = (DatabaseAdapter.baseAdapter.getAllElements() as! Results<Devices>)[indexPath.row]
        cell.device = device
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row > -1) {
            item = (DatabaseAdapter.baseAdapter.getAllElements() as! Results<Devices>)[indexPath.row] as Devices
            self.performSegue(withIdentifier: "editDeviceSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseAdapter.baseAdapter.delegate = self
        navigationItem.title = "Back-End"
    }

    // удаление ячейки с элементом через свайп
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let device = (DatabaseAdapter.baseAdapter.getAllElements() as! Results<Devices>)[indexPath.row] as Devices
            DatabaseAdapter.baseAdapter.deleteElement(device: device.name)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDeviceSegue" {
            let toViewController = segue.destination as! DeviceViewController
     toViewController.currentDevice = item
        toViewController.navigationItem.title = "Edit Device"
            navigationItem.title = "-"
        }
    }
    
    func updateData() {
        tableView.reloadData()
    }

}

