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
    @IBOutlet weak var TaskLabel: UILabel!
    @IBOutlet weak var TaskInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view - load data and redisplay
        
         TaskInput.text = "current daily task" // eventually have an if statement that references only current daily task
        
    }

   
    // actions and methods
    
    
    @IBAction func createTask(_ sender: UIButton) {
        let realm = try! Realm()
        let task = DailyTask(value: ["name": TaskInput.text!]) //should be name: but won't let me put that
        //to add to realm
        try! realm.write {
            realm.add(task)
        }
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
