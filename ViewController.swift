//
//  ViewController.swift
//  ToDoList
//
//  Created by ALEXANDRU-DAN CATRUC on 15.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var toDoTasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "SAVED TASKS"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // setup
        
        if !UserDefaults().bool(forKey: "setup")
        {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTasks()
        
    }
    
    

    func updateTasks()
    {
        toDoTasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {
            return
        }
        
        for x in 0..<count
        {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String
            {
                toDoTasks.append(task)
            }
        }
        
        tableView.reloadData()
        
    }
    
    
    @IBAction func didTapAdd()
    {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        viewController.title = "NEW TASK"
        viewController.updated =
        {
            DispatchQueue.main.async {
                self.updateTasks()
            }
            
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ViewController: UITableViewDelegate
{
    
    // function to select the rows
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "task") as! TasksViewController
        viewController.title = "TASK"
        viewController.task = toDoTasks[indexPath.row]
        viewController.currentPosition = indexPath.row
        navigationController?.pushViewController(viewController, animated: true)
    }

    
}

extension ViewController: UITableViewDataSource
{
    // function which returns number of tasks
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = toDoTasks[indexPath.row]
        
        return cell
    }
}

