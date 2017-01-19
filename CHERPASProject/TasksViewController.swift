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
    @IBOutlet weak var selectLabel: UILabel!
    
    var recentTasks = [String]()
    
//    var list = ["1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        queryTasks()
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
        
        return recentTasks.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return recentTasks[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.TaskInput.text = self.recentTasks[row]
//        self.TaskInput.textColor = UIColor.white
        self.dropDown.isHidden = true
        self.selectLabel.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.TaskInput {
            self.dropDown.isHidden = false
            self.selectLabel.isHidden = false
            //if you dont want the users to se the keyboard type:
        }
        
    }
    
    func queryTasks() {
        
        let startOfDay = Calendar.current.startOfDay(for: Date() as Date)
        
        
        let weekEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        
        
        let weekStart: Date = {
            var components = DateComponents()
            components.day = -7
            components.second = -1
            return Calendar.current.date(byAdding: components, to: weekEnd)!
        }()
        
        let realm = try! Realm()
        
        let allTasks = realm.objects(DailyTask)
        // will also need to add filter so that it includes only appropriate category as well
        let currentTasks = allTasks.filter("createdAt BETWEEN %@", [weekStart, weekEnd])
        let tasksByCategory = currentTasks.filter("category = %@", passedCategory)
        
        for task in tasksByCategory {
        
            recentTasks.append(task.name)
        
        }
        
    }

}
