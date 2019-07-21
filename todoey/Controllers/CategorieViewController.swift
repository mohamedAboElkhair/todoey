//
//  CategorieViewController.swift
//  todoey
//
//  Created by Mohamed Abo Elkhair on 7/2/19.
//  Copyright © 2019 Mohamed Abo Elkhair. All rights reserved.
//

import UIKit
import CoreData
class CategorieViewController: UITableViewController {

    // var
    var categories = [Categorie]()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            loadCategorie()
        
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categItem", for: indexPath)
        // also like this 
      //  let categ = categArray[indexPath.row]
       // cell.textLabel?.text = categ.name
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
      // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItem", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if  let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    
    

    //MARK:  -  Data Manipulation Methods
    func saveCategorie(){
        do{
            try context.save()
        }catch{
            print("error encode \(error)")
        }
        self.tableView.reloadData()
    }
    func loadCategorie(with request : NSFetchRequest<Categorie> = Categorie.fetchRequest()){
        do{
            categories =  try context.fetch(request)
        }catch{
            print("loadItem Error \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Categories
    @IBAction func addCategorie(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Categorie", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add Categorie", style: .default) { (alert) in
            let newCateg = Categorie(context: self.context)
            newCateg.name = textField.text!
            self.categories.append(newCateg)
            self.saveCategorie()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Name"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
        
    }
    
}

