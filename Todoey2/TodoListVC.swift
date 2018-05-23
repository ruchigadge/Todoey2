//
//  ViewController.swift
//  Todoey2
//
//  Created by Ruchi Gadge on 08/05/18.
//  Copyright © 2018 Ruchi Gadge. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {

    var itemArray = ["Wash Cloths", "Buy Eggs", "Prepare Lunch"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
        }
    }

    //MARK :- Tableview Datasourse Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK :- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
        
        if (tableView.cellForRow(at: indexPath))?.accessoryType == .checkmark{
            (tableView.cellForRow(at: indexPath))?.accessoryType = .none
        }else {
            (tableView.cellForRow(at: indexPath))?.accessoryType = .checkmark
        }
                
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK :- Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Item", style: .default) {action in
            // what will happen once the user clicks the Add Item button on our UIAlert
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

