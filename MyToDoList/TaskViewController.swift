//
//  TaskViewController.swift
//  MyToDoList
//
//  Created by emmanuel rudelle on 08/08/2021.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var label: UILabel!
    var task: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = task
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self,
                                                            action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
        currentItems = currentItems.filter(){$0 != task}
        UserDefaults.standard.setValue(currentItems, forKey: "items")
        navigationController?.popViewController(animated: true)
        
    }
}
