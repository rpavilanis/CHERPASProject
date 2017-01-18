//
//  CategoriesViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/3/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesViewController: UITableViewController {
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    var categories = ["Cleanliness", "Healthy Eating", "Exercise", "Relationships", "Personal Development", "Action-Based Living", "Spirituality"]
    
    var dailyTask = [String]()
    var monthlyGoals = [String]()
    
//    var monthlyGoals = ["Clean for 15 minutes each day.", "H Goal", "E Goal", "R Goal", "P Goal", "A Goal",
//        "S Goal"]
    
    var yearlyGoals = ["At monthly check-ins, the apartment will be clean and organized due to gradual daily cleaning.", "H Goal", "E Goal", "R Goal", "P Goal", "A Goal","S Goal"]
    
    var quotes = ["Our goals can only be reached through a vehicle of a plan, in which we must fervently believe and upon which we must vigorously act. There is no other route to success.", "H Quote", "E Quote", "R Quote", "P Quote", "A Goal","S Quote"]


    override func viewDidLoad() {
        super.viewDidLoad()
        queryTasks()
        queryGoals()
        btnMenuButton.target = revealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        // This removes the label on the back bar - remove this if I want to add label back in for this.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        let categoryName = categories[indexPath.row]
        cell.textLabel?.text = categories[indexPath.row]
        cell.imageView?.image = UIImage(named: categoryName)
       
        cell.detailTextLabel?.text = dailyTask[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dayOverview" {
            let dayOverview = segue.destination as! DayOverviewViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let taskItem = dailyTask[indexpath.row] as String
                dayOverview.sentData1 = taskItem
                
                let monthGoal = monthlyGoals[indexpath.row] as String
                dayOverview.sentData2 = monthGoal
                
                let yearGoal = yearlyGoals[indexpath.row] as String
                dayOverview.sentData3 = yearGoal
                
                let dailyQuote = quotes[indexpath.row] as String
                dayOverview.sentData4 = dailyQuote
                
                let CHERPAS = categories[indexpath.row] as String
                dayOverview.sentData5 = CHERPAS
            }
        }
    }
    
    func queryTasks() {
        
        let todayStart = Calendar.current.startOfDay(for: Date() as Date)
        let todayEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: todayStart)!
        }()
        
        let realm = try! Realm()
        
        let allTasks = realm.objects(DailyTask)
        // will also need to add filter so that it includes only appropriate category as well
        let currentTask = allTasks.filter("createdAt BETWEEN %@", [todayStart, todayEnd])
        
        for task in currentTask{
            if task.category == "Cleanliness" {
                dailyTask.append(task.name)
            }
        }
        
        if dailyTask.count == 0 {
            dailyTask.append("")
        }
        
        for task in currentTask{
            if task.category == "Healthy Eating" {
                dailyTask.append(task.name)
            }
        }
        
        if dailyTask.count == 1 {
            dailyTask.append("")
        }
        
        for task in currentTask{
            if task.category == "Exercise" {
                dailyTask.append(task.name)
            }
        }
        
        if dailyTask.count == 2 {
            dailyTask.append("")
        }
        
        
        for task in currentTask{
            if task.category == "Relationships" {
                dailyTask.append(task.name)
            }
        }
        
        if dailyTask.count == 3 {
            dailyTask.append("")
        }
        
        for task in currentTask{
            if task.category == "Personal Development" {
                dailyTask.append(task.name)
            }
        }
        
        if dailyTask.count == 4 {
            dailyTask.append("")
        }
        
        for task in currentTask{
            if task.category == "Action-Based Living" {
                dailyTask.append(task.name)
            }
        }
        
        if dailyTask.count == 5 {
            dailyTask.append("")
        }
        
        for task in currentTask{
            if task.category == "Spirituality" {
                dailyTask.append(task.name)
            }
        }
        
        if dailyTask.count == 6 {
            dailyTask.append("")
        }
        
         tableView.reloadData()
        
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
            components.day = -30
            components.second = -1
            return Calendar.current.date(byAdding: components, to: monthEnd)!
        }()
        
        let realm = try! Realm()
        
        let allGoals = realm.objects(Goal)
        print(allGoals)
        // will also need to add filter so that it includes only appropriate category as well
        let currentGoals = allGoals.filter("createdAt BETWEEN %@", [monthStart, monthEnd])
        print(currentGoals)
        for goal in currentGoals{
            if goal.category == "Cleanliness" && goal.timeSpan == "Month" {
                monthlyGoals.append(goal.desc)
            }
        }
        
        if monthlyGoals.count == 0 {
            monthlyGoals.append("")
        }
        
        for goal in currentGoals{
            if goal.category == "Healthy Eating" && goal.timeSpan == "Month" {
                monthlyGoals.append(goal.desc)
            }
        }

        if monthlyGoals.count == 1 {
            monthlyGoals.append("")
        }
        
        for goal in currentGoals{
            if goal.category == "Exercise" && goal.timeSpan == "Month" {
                monthlyGoals.append(goal.desc)
            }
        }
        
        if monthlyGoals.count == 2 {
            monthlyGoals.append("")
        }
        
        for goal in currentGoals{
            if goal.category == "Relationships" && goal.timeSpan == "Month" {
                monthlyGoals.append(goal.desc)
            }
        }
        
        if monthlyGoals.count == 3 {
            monthlyGoals.append("")
        }
        
        for goal in currentGoals{
            if goal.category == "Personal Development" && goal.timeSpan == "Month" {
                monthlyGoals.append(goal.desc)
            }
        }
        
        if monthlyGoals.count == 4 {
            monthlyGoals.append("")
        }
        
        for goal in currentGoals{
            if goal.category == "Action-Based Living" && goal.timeSpan == "Month" {
                monthlyGoals.append(goal.desc)
            }
        }
        
        if monthlyGoals.count == 5 {
            monthlyGoals.append("")
        }
        
        for goal in currentGoals{
            if goal.category == "Spirituality" && goal.timeSpan == "Month" {
                monthlyGoals.append(goal.desc)
            }
        }
        
        if monthlyGoals.count == 6 {
            monthlyGoals.append("")
        }
        print(monthlyGoals)
        tableView.reloadData()
        
    }

}


