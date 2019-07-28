//
//  ViewController.swift
//  todoey
//
//  Created by Mohamed Abo Elkhair on 6/13/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    
     //MARK: -  Var Item Array
    var itemArry: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Categorie?{
        didSet{
             loadItems()
        }
    }
     
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
    }
    
    //MARK: -  TabelView DataSours Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry?.count ?? 1
    }
    
    // tableView  Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        
        if let item = itemArry?[indexPath.row]{
            cell.textLabel?.text = item.title
            // if
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No title"
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArry?[indexPath.row]{
            do {
                try realm.write {
                    // for delete item       realm.delete(item)
                item.done = !item.done
                }
            }catch{
                print("error update \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: -  ActionAdd Item
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()

      let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (alert) in
            
            if let currentCateg = self.selectedCategory {
                do{
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCateg.items.append(newItem)
                    }
                }catch{
                    print("Error save \(error)")
                }
            }
                self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "ADD NEW ITEM"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
       //MARK: -  ActionAdd Item
    func saveItem(item : Item){
        do{
            try realm.write {
                realm.add(item)
            }
        }catch{
         print("error encode \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems(){
            itemArry = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}
 //MARK: -  Search bar Delegate
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        itemArry = itemArry?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    
    //MARk: go and back
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
