//
//  CatagoreyViewController.swift
//  Todoey
//
//  Created by Michael Abrams on 9/4/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CatagoreyViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist")
        }
        
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
    }

    // MARK: - Table view data source

    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        tableView.separatorStyle = .none
        if let category = categoryArray?[indexPath.row] {
            
            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: category.hexColor)!, returnFlat: true)
            cell.backgroundColor = UIColor(hexString: (category.hexColor))
            cell.textLabel?.text = category.name
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var categoryName = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            let hexCode = UIColor.randomFlat().hexValue()
            newCategory.name = categoryName.text!
            newCategory.hexColor = hexCode
            self.save(category: newCategory)
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add a new category"
            categoryName = textField
        }
        
        alert.addAction(action)
        
       
        
        self.present(alert, animated: true, completion: nil)
            
    }
    
    //MARK: - TableView DataSource Methods
    
    func save(category : Category) {
        do {
            try realm.write() {
                realm.add(category)
            }
        } catch {
            print("There was an error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        categoryArray = realm.objects(Category.self)

        tableView.reloadData()
    }
    //MARK:  - TableView Delegate Methods
        
    //MARK: - Data Manipulation Methods
}

