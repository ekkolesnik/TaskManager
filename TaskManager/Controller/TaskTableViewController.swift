//
//  TaskTableViewController.swift
//  TaskManager
//
//  Created by Evgeny Kolesnik on 23.06.2020.
//  Copyright © 2020 Evgeny Kolesnik. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()

        if task == nil {
            task = rootItem
        }
        
        navigationItem.title = task?.nameTask
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (task?.subItems.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else { preconditionFailure("Can't create TaskCell") }

        let itemForCell = task!.subItems[indexPath.row]
        cell.taskLabel.text = itemForCell.nameTask
        
        cell.taskCountLabel.text = String(itemForCell.subItems.count)


        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            task?.removeSubItem(index: indexPath.row)
            saveData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subItem = task?.subItems[indexPath.row]
        
        let toDoListVC = storyboard?.instantiateViewController(withIdentifier: "todoSID") as! TaskTableViewController
        toDoListVC.task = subItem
        
        navigationController?.pushViewController(toDoListVC, animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Добавить задачу", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Сделать задачу"
        }
        
        let alertActionCreate = UIAlertAction(title: "Создать", style: UIAlertAction.Style.default) { (alertAction) in
            
            if alert.textFields![0].text != "" {
                let newItem = Task(nameTask: alert.textFields![0].text!)
                
                self.task?.addSubItem(subItem: newItem)
                self.tableView.reloadData()
                saveData()
            }
        }
        
        let alertActionCancel = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel) { (alert) in
            
        }
        
        alert.addAction(alertActionCreate)
        alert.addAction(alertActionCancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}
