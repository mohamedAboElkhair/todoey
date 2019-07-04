//
//  ViewController.swift
//  todoey
//
//  Created by Mohamed Abo Elkhair on 6/13/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    
     //MARK: -  Var Item Array
    var itemArry = [Item]()
    var selectedCategory : Categorie?{
        didSet{
             loadItems()
        }
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    
     

    }
    
    //MARK: -  TabelView DataSours Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    
    // tableView  Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        
        let item = itemArry[indexPath.row]
        
        cell.textLabel?.text = item.title
        // if
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArry[indexPath.row])
//        itemArry.remove(at: indexPath.row)

        itemArry[indexPath.row].done = !itemArry[indexPath.row].done
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: -  ActionAdd Item
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
      let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (alert) in
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategorie = self.selectedCategory
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
       //MARK: -  ActionAdd Item
    func saveItem(){
        do{
         try context.save()
        }catch{
         print("error encode \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()){
        do{
            itemArry =  try context.fetch(request)
        }catch{
            print("loadItem Error \(error)")
        }
        tableView.reloadData()
    }
}
 //MARK: -  Search Bar Delegate
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@",searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with :request)
    }
    
    //MARk: go
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
