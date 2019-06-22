//
//  ViewController.swift
//  todoey
//
//  Created by Mohamed Abo Elkhair on 6/13/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    

    var itemArry = [Item]()
   
//    var defaults = UserDefaults.standard
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
//        let newItem = Item()
//        newItem.titel = "find Malik"
//     
//        itemArry.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.titel = "find me"
//        itemArry.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.titel = "find you"
//        itemArry.append(newItem3)
        
        loadItems()
//        if  let items = defaults.array(forKey: "itemName") as? [Item]{
//
//            itemArry = items
//        }
    }
    
    // TabelView DataSours Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    
    // tableView  Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        
        let item = itemArry[indexPath.row]
        
        cell.textLabel?.text = item.titel
        // if
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArry[indexPath.row].done = !itemArry[indexPath.row].done
        saveItem()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
      let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (alert) in
            let newItem = Item()
            
            newItem.titel = textField.text!
            
         //   self.defaults.set(self.itemArry, forKey: "itemName")
            
            self.itemArry.append(newItem)
            
            self.saveItem()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "ADD NEW ITEM"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    func saveItem(){
        let encodeer = PropertyListEncoder()
        
        do{
            let data = try encodeer.encode(itemArry)
            try data.write(to: dataFilePath!)
            
        }catch{
            print("error encode \(error)")
        }
        tableView.reloadData()
        
        
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArry = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("decoder Error \(error)")
            }
        }
        
    }
}
