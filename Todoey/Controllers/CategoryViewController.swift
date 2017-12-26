//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mohamed Ibrahim on 2017-12-25.
//  Copyright © 2017 Mohamed Ibrahim. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    // datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added"
        
        
        return cell
    }
    
    // delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    // data manipulation methods
    func save(category: Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving to context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)

        tableView.reloadData()
        
    }
    
    // Add button pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category name"
            textField = alertTextField
        }
        
        let addAction = UIAlertAction(title: "Add category", style: .default) { (action) in
            if textField.text! == "" {
                alert.dismiss(animated: true, completion: {
                    print("dismissed because of empty string")
                })
            } else {
                let newCategory = Category()
                newCategory.name = textField.text!
             
                
                self.save(category: newCategory)
            }
        }
        
        alert.addAction(addAction)
        
        present(alert, animated: true)
        
        
    }
    
    

}
