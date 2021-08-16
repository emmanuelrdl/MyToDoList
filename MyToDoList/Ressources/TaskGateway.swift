//
//  TaskGateway.swift
//  MyToDoList
//
//  Created by emmanuel rudelle on 13/08/2021.
//

import Foundation
import FirebaseFirestore

public struct Item {
    var label: String
}

class TaskGateway {
    let database = Firestore.firestore()
    
    func readTasks(_ completion: @escaping (_ data: [Item]?) -> Void) {
        database.collection("tasks").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                completion(querySnapshot!.documents.map({ item in
                    let task = item.data()
                    let label = task["label"] as? String ?? ""
                    return Item(label: label)
                }))
            }
        }
    }
    
    func createTask(task : String) {
        database.collection("tasks").addDocument(data: ["label": task])
    }
    

}
