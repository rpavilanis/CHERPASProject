//
//  TasksViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/4/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift



class TasksViewController: UIViewController {
    // outlets and variables
    var passedCategory:String!
    
    @IBOutlet weak var TaskLabel: UILabel!
    @IBOutlet weak var TaskInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskLabel.text = "Add Daily Task for " + passedCategory

        // Do any additional setup after loading the view - load data and redisplay
        
//         TaskInput.text = "current daily task" // eventually have an if statement that references only current daily task
        
    }

   
    // actions and methods
    
    
    @IBAction func createTask(_ sender: UIButton) {
        // on button click, adds this task to the Realm database
        let task = DailyTask()
        task.name = TaskInput.text!
        task.category = passedCategory
        let realm = try! Realm()
        try! realm.write {
            realm.add(task)
            print("Added \(task.name) to Realm")
            print(task.isCompleted)
            print(task.createdAt)
            print(task.category)
        }
        dismiss(animated: true, completion: nil)
    }
    

}
