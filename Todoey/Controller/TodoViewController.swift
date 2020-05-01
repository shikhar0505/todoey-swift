//
//  ViewController.swift
//  Todoey
//
//  Created by Shikhar Kumar on 2/4/20.
//  Copyright © 2020 Shikhar Kumar. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

    var todoItems: [TodoListItem] = []
    let userDataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("userData.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    // MARK: - TableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = todoItems[indexPath.row].itemTitle
        cell.accessoryType = todoItems[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        saveItems()
    }
    
    // MARK: - Add new item
    
    @IBAction func addITodotemPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != "" {
                self.todoItems.append(TodoListItem(itemTitle: textField.text!))
                self.saveItems()
            }
        }
        
        alert.addTextField { (field) in
            field.placeholder = "Add new item"
            textField = field
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Load data from file
    
    func saveItems() {
        do {
            let data = try PropertyListEncoder().encode(todoItems)
            try data.write(to: userDataPath!)
        } catch {
            print("Error encoding data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: userDataPath!) {
            do {
                todoItems = try PropertyListDecoder().decode([TodoListItem].self, from: data)
            } catch {
                print("Error decoding data \(error)")
            }
        }
    }
}

