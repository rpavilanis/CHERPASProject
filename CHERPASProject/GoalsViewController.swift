//
//  GoalsViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/13/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift

class GoalsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var GoalLabel: UILabel!
    @IBOutlet weak var GoalInput: UITextField!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var dropDown: UIPickerView!
    
    var recentGoals = [String]()
    
    var passedCategory:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryGoals()
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

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return recentGoals.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return recentGoals[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.GoalInput.text = self.recentGoals[row]
        //        self.TaskInput.textColor = UIColor.white
        self.dropDown.isHidden = true
        self.selectLabel.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.GoalInput {
            self.dropDown.isHidden = false
            self.selectLabel.isHidden = false
            //if you dont want the users to se the keyboard type:
        }
        
    }
    
    func queryGoals() {
        
        let startOfDay = Calendar.current.startOfDay(for: Date() as Date)
        
        
        let monthEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        
        let monthStart: Date = {
            var components = DateComponents()
            components.day = -90
            components.second = -1
            return Calendar.current.date(byAdding: components, to: monthEnd)!
        }()
        
        let realm = try! Realm()
        
        let allGoals = realm.objects(Goal)
        print(allGoals)
        // will also need to add filter so that it includes only appropriate category as well
        let currentGoals = allGoals.filter("createdAt BETWEEN %@", [monthStart, monthEnd])
        let goalsByCategory = currentGoals.filter("category = %@", passedCategory)
        
        for goal in goalsByCategory {
            
            recentGoals.append(goal.desc)
            
        }
        
    }



}
