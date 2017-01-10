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

        // Do any additional setup after loading the view - load data and redisplay
        
         TaskInput.text = "current daily task" // eventually have an if statement that references only current daily task
        
    }

   
    // actions and methods
    
    
    @IBAction func createTask(_ sender: UIButton) {
//        let realm = try! Realm()
//        let task = DailyTask(value: ["name": TaskInput.text!]) //should be name: but won't let me put that
//        //to add to realm
//        try! realm.write {
//            realm.add(task)
//        }
        
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
