//
//  ViewController.swift
//  todoey
//
//  Created by Mohamed Abo Elkhair on 6/13/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    

    let itemArry = ["findMaik", "Buy Eggas","Dester Deam "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // TabelView DataSours Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        
        cell.textLabel?.text = itemArry[indexPath.row]
        return cell
    }
    
    // tableView  Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else{
              tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
}

