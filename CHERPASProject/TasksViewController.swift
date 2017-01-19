//
//  TasksViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/4/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift



class TasksViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    // outlets and variables
    var passedCategory:String!
    
    @IBOutlet weak var TaskLabel: UILabel!
    @IBOutlet weak var TaskInput: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    var list = ["1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskLabel.text = "Add Daily Task for " + passedCategory
    }

   
    // actions and methods
    
    @IBAction func taskInput(_ sender: UITextField) {
        self.view.endEditing(true);
    }
    
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
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.TaskInput.text = self.list[row]
        self.dropDown.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.TaskInput {
            self.dropDown.isHidden = false
            //if you dont want the users to se the keyboard type:
        }
        
    }
    

}
