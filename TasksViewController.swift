//
//  TasksViewController.swift
//  ToDoList
//
//  Created by ALEXANDRU-DAN CATRUC on 15.02.2023.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet var label : UILabel!
    
    var task : String?
    
    var currentPosition: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask(_ sender: UIBarButtonItem) {
        guard let currentPosition = self.currentPosition else {
            return
        }
        
        let count = UserDefaults.standard.integer(forKey: "count")
        
        UserDefaults.standard.removeObject(forKey: "task_\(currentPosition+1)")
        
        for i in currentPosition+1..<count {
            let task = UserDefaults.standard.string(forKey: "task_\(i+1)")
            UserDefaults.standard.setValue(task, forKey: "task_\(i)")
        }
        
        UserDefaults.standard.setValue(count-1, forKey: "count")
        
        // Call updateTasks() to reload the tasks from UserDefaults and update the table view
        if let viewController = navigationController?.viewControllers.first as? ViewController {
            viewController.updateTasks()
        }
        
        navigationController?.popViewController(animated: true)
    }


}
