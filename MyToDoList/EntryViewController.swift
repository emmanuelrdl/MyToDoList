//
//  EntryViewController.swift
//  MyToDoList
//
//  Created by emmanuel rudelle on 08/08/2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
        
        guard let task = field.text, !task.isEmpty else {
            return
        }
        
        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
        currentItems.append(task)
        TaskGateway().createTask(task: task)
        UserDefaults.standard.setValue(currentItems, forKey: "items")
        update?()
        navigationController?.popViewController(animated: true)
    }
    

}
