//
//  ViewController.swift
//  MyToDoList
//
//  Created by emmanuel rudelle on 07/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [String]()
    
    @IBOutlet var tableView: UITableView!
    
//    private let table: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        return table
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTasks()
        print("self.items", self.items)
        title = "My Todo List"
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        updateTasks()
    }
    
    @objc private func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func updateTasks() {
        items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "Edit task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        vc.task = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
