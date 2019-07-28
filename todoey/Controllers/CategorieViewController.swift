//
//  CategorieViewController.swift
//  todoey
//  Created by Mohamed Abo Elkhair on 7/2/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import UIKit
import RealmSwift
class CategorieViewController: UITableViewController {

    // var
    let realm = try! Realm()
    var categories : Results<Categorie>?
    override func viewDidLoad() {
        super.viewDidLoad()
            load()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categItem", for: indexPath)
        // also like this 
      //  let categ = categArray[indexPath.row]
       // cell.textLabel?.text = categ.name
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Add"
        return cell
    }
      // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItem", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if  let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    //MARK:  -  Data Manipulation Methods
    func save(categorie: Categorie){
        do{
            try realm.write {
                realm.add(categorie)
            }
        }catch{
            print("error encode \(error)")
        }
        self.tableView.reloadData()
    }
    func load(){
          categories = realm.objects(Categorie.self)
            tableView.reloadData()
    }
    
    //MARK: - Add New Categories
    @IBAction func addCategorie(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Categorie", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Categorie", style: .default) { (alert) in
            let newCateg = Categorie()
            newCateg.name = textField.text!
            self.save(categorie: newCateg)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Name"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
        
    }
    
}

