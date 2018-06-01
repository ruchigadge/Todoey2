//
//  CategoryViewController.swift
//  Todoey2
//
//  Created by Ruchi Gadge on 28/05/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
    }
    
    //Mark: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    //Mark: - Tableview Delegate Mathods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListVC
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexpath.row]
        }
    }
    
    //Mark: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Category", style: .default) { action in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //Mark: - Data Manipulation Methods
    
    func saveCategory() {
        
        do{
            try context.save()
        }catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error loading data \(error)")
        }
        tableView.reloadData()
    }
    
}
