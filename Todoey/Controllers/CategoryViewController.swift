//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mohamed Ibrahim on 2017-12-25.
//  Copyright © 2017 Mohamed Ibrahim. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext 
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    // datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        
        return cell
    }
    
    // delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    // data manipulation methods
    func saveCategories(){
        
        do{
            try context.save()
        } catch {
            print("error saving to context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        do {
            categories = try context.fetch(Category.fetchRequest())
        } catch {
            print("couldn't fetch categories: \(error)")
        }
        
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
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                self.categories.append(newCategory)
                
                self.saveCategories()
            }
        }
        
        alert.addAction(addAction)
        
        present(alert, animated: true)
        
        
    }
    
    

}
