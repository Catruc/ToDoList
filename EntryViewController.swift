//
//  EntryViewController.swift
//  ToDoList
//
//  Created by ALEXANDRU-DAN CATRUC on 15.02.2023.
//

import UIKit

class EntryViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet var entryField : UITextField!
    
    var updated : (() -> Void )?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryField.delegate=self
        entryField.keyboardType = .asciiCapable
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: .done, target: self, action: #selector(saveATask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveATask()
        
        return true
    }
    
    @objc func saveATask()
    {
        guard let text = entryField.text , !text.isEmpty else
        {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {
            return
        }
        
        let theNewCount = count + 1
        
        UserDefaults().set(theNewCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(theNewCount)")
        
        updated?()
        
        navigationController?.popViewController(animated: true)
    }
    

}
