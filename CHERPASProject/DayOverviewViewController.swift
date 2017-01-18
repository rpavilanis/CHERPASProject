//
//  DayOverviewViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/5/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift

class DayOverviewViewController: UITableViewController {

    
    let section = ["Daily Task", "Monthly Goal", "Yearly Goal", "Quote of the Day"]

    
    // stores dailyTask information passed from category view
    var sentData1:String!
    var sentData2:String!
    var sentData3:String!
    var sentData4:String!
    var sentData5:String!
    var dailyTask = [String]()
    var monthlyGoals = [String]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
//            queryTasks()
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationItem.title = sentData5
            
        
            
//            let realm = try! Realm()
//            let tasks = realm.objects(DailyTask.self)
//            print(tasks)
//            let item = tasks[indexPath.row]
//            print(item)
//            //            let tasksToday = realm.objects(DailyTask.self).filter("createdAt BETWEEN %@", [todayStart, todayEnd])
//            if item.isCompleted == true {
//                
//                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData1)
//                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
//                let cell = tableView.cellForRow(at: indexPath)
//                cell?.textLabel?.attributedText =  attributeString
//            }
            
        }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section [section]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return self.items [section].count
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath)
        
        cell.selectionStyle = .none

        let todayStart = Calendar.current.startOfDay(for: Date() as Date)
        let todayEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: todayStart)!
        }()
        
        let realm = try! Realm()
        
        let tasksToday = realm.objects(DailyTask.self).filter("createdAt BETWEEN %@", [todayStart, todayEnd])
        let selectedTask = tasksToday.filter("name = %@", self.sentData1)
        print(selectedTask)
        
        for task in selectedTask {
            
            if task.isCompleted == true {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData1)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.textLabel?.attributedText =  attributeString
            }
        }

        
        switch (indexPath.section)
        {
        case 0:
            cell.textLabel?.text = sentData1
        case 1:
            cell.textLabel?.text = sentData2
        case 2:
            cell.textLabel?.text = sentData3
        case 3:
            cell.textLabel?.text = sentData4
        default:
            cell.textLabel?.text = "Other"
            
        }
        return cell
        
    }

    // This allows me to change color of section headers within my tableView
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        super.tableView(tableView, editActionsForRowAt: indexPath)
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let todayStart = Calendar.current.startOfDay(for: Date() as Date)
            let todayEnd: Date = {
                var components = DateComponents()
                components.day = 1
                components.second = -1
                return Calendar.current.date(byAdding: components, to: todayStart)!
            }()
            
            let realm = try! Realm()
            
            let tasksToday = realm.objects(DailyTask.self).filter("createdAt BETWEEN %@", [todayStart, todayEnd])
            let selectedTask = tasksToday.filter("name = %@", self.sentData1)
            
            try! realm.write {
                realm.delete(selectedTask)
                // then need to reload table view here so that it shows task was deleted!!
//                let paths = [indexPath]
//                tableView.reloadRows(at: paths, with: UITableViewRowAnimation.none)
            }
//            self.tableView.reloadData()
            self.performSegue(withIdentifier: "onDelete", sender: self)
  
        }
        delete.backgroundColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)

        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("edit button tapped")
        }
        edit.backgroundColor = UIColor(red: 130/255, green: 208/255, blue: 216/255, alpha: 1.0)
        
        // need to adjust this with if statement once add in model - if task is complete already, need to be able to change to incomplete
        let markComplete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
            let todayStart = Calendar.current.startOfDay(for: Date() as Date)
            let todayEnd: Date = {
                var components = DateComponents()
                components.day = 1
                components.second = -1
                return Calendar.current.date(byAdding: components, to: todayStart)!
            }()
            
            let realm = try! Realm()
            
            let tasksToday = realm.objects(DailyTask.self).filter("createdAt BETWEEN %@", [todayStart, todayEnd])
            let selectedTask = tasksToday.filter("name = %@", self.sentData1)[indexPath.row]
            print(selectedTask)
            
            try! realm.write {
                selectedTask.isCompleted = true
                print(selectedTask)
                
            }
            if selectedTask.isCompleted == true {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData1)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.attributedText =  attributeString
            }
            let paths = [indexPath]
            tableView.reloadRows(at: paths, with: UITableViewRowAnimation.none)

            //remove strikethrough
            // cell.textLabel?.attributedText =  nil
        }
        markComplete.backgroundColor = UIColor(red: 0/255, green: 66/255, blue: 89/255, alpha: 1.0)
        return [edit, delete, markComplete]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    
//    func queryTasks() {
//        
//        let todayStart = Calendar.current.startOfDay(for: Date() as Date)
//        let todayEnd: Date = {
//            var components = DateComponents()
//            components.day = 1
//            components.second = -1
//            return Calendar.current.date(byAdding: components, to: todayStart)!
//        }()
//        
//        let realm = try! Realm()
//        
//        let allTasks = realm.objects(DailyTask)
//        // will also need to add filter so that it includes only appropriate category as well
//        let currentTask = allTasks.filter("createdAt BETWEEN %@", [todayStart, todayEnd])
//        
//        for task in currentTask{
//            dailyTask.append(task.name)
//        
//        tableView.reloadData()
//        }
//        
//    }
    
//    func queryTasks() {
//        
//        let todayStart = Calendar.current.startOfDay(for: Date() as Date)
//        let todayEnd: Date = {
//            var components = DateComponents()
//            components.day = 1
//            components.second = -1
//            return Calendar.current.date(byAdding: components, to: todayStart)!
//        }()
//
//        let realm = try! Realm()
//        
////        let allTasks = realm.objects(DailyTask.self)
//        var tasksToday = realm.objects(DailyTask.self).filter("createdAt BETWEEN %@", [todayStart, todayEnd])
//        tasksToday.filter("name = ''")
//    }
    
    
    // query tasks - do the filter for current day - then just delete the one corresponding to the indexpath row??
}
