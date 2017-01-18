//
//  GoalsViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/13/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift

class GoalsViewController: UIViewController {
    @IBOutlet weak var GoalLabel: UILabel!
    @IBOutlet weak var GoalInput: UITextField!
    
    var passedCategory:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoalLabel.text = "Add Monthly Goal for " + passedCategory


        // Do any additional setup after loading the view.
    }
    
    @IBAction func goalInput(_ sender: UITextField) {
        self.view.endEditing(true);
    }
   
    
    @IBAction func createGoal(_ sender: UIButton) {
        let goal = Goal()
        goal.desc = GoalInput.text!
        goal.timeSpan = "Month"
        goal.category = passedCategory
        let realm = try! Realm()
        try! realm.write {
            realm.add(goal)
            print("Added \(goal.desc) to Realm")
            print(goal.isCompleted)
            print(goal.createdAt)
            print(goal.category)
            print(goal.timeSpan)
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
