//
//  ViewController.swift
//  MyToDoList
//
//  Created by emmanuel rudelle on 07/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [Item]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTasks()
        print("self.items", self.items)
        title = "My Todo List"
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
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
        TaskGateway().readTasks() { (data) in
            if let values = data as? [Item] {
                self.items = values
                print("self.items")
                print(self.items)
            } else {
                // we have something else
            }
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print("table view items")
        print(self.items)
        cell.textLabel?.text = self.items[indexPath.row].label
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
        vc.task = self.items[indexPath.row].label
        navigationController?.pushViewController(vc, animated: true)
    }
}
