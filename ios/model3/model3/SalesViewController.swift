//
//  TableViewController.swift
//  model3
//
//  Created by Francis Robichaud on 2016-04-04.
//  Copyright © 2016 PetalMD. All rights reserved.
//
import UIKit
import Foundation
import ActionCableClient
import Alamofire

class SalesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let WS_HOST = "127.0.0.1"
    let WS_PORT = 3000
    
    private var client:ActionCableClient?
    
    struct Sale {
        var name  = ""
        var amount = 0
    }
    
    @IBOutlet weak var _total: UILabel!
    @IBOutlet weak var _tableView: UITableView!
    
    private var _data = [Sale]()
    private var _currentTotal = 0
    
    override func viewDidLoad() {
        getSales()
        
        client = ActionCableClient(URL: NSURL(string: "ws://\(WS_HOST):\(WS_PORT)/cable")!)
        client!.origin = WS_HOST
        client!.connect()
        
        client!.create("SalesChannel")
        client!.onChannelReceive = onReceive
    }
    
    // MARK: Websocket
    func onReceive(chan:Channel, obj:AnyObject?, error:ErrorType?) {
        let response = obj as! NSDictionary
        let name = response["name"] as! String
        let amount = response["amount"] as! Int
        
        _data.insert(Sale(name: name, amount: amount), atIndex: 0)
        _tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
        _currentTotal += amount
        updateTotal()
    }
    
    private func updateTotal() {
        self._total!.text = "$\(self._currentTotal)"
    }
    
    // MARK: REST API
    private func getSales() {
//        Alamofire.request(.GET, "http://private-5df9d-model3.apiary-mock.com/sales")
        Alamofire.request(.GET, "http://\(WS_HOST):\(WS_PORT)/sales")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    let response = JSON as! NSDictionary
                    self._currentTotal = response["total"] as! Int
                    self.updateTotal()
                    self._data = (response["sales"] as! NSArray).map { sale in
                        let name = sale["name"] as! String
                        let amount = sale["amount"] as! Int
                        return Sale(name: name, amount: amount)
                    }
                    self._tableView.reloadData()
                }
        }
    }
    
    // MARK: Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("random")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "random")
        }
        
        cell!.textLabel!.text = _data[indexPath.row].name
        return cell!
    }
}