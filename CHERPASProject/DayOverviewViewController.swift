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

    
    @IBOutlet weak var quoteBox: UILabel!
    let section = ["Daily Task", "Monthly Goal", "Yearly Goal"]
    
    var quotes = ["Our goals can only be reached through a vehicle of a plan, in which we must fervently believe and upon which we must vigorously act. There is no other route to success.", "If you are not prepared to be wrong, you will never come up with anything original. -Sir Ken Robinson", "Your power does not come from luck. Your power comes from you, and what you invest in it every day, in the work and the sweat and the giving a damn. - Rachel Sklar", "Imperfect action is better than a perfect plan.", "I want to be around people that do things. I don’t want to be around people anymore that judge or talk about what people do. I want to be around people that dream and support and do things.", "How wild it was, to let it be. - Cheryl Strayed","At any given moment, you have the power to say: This is not how the story is going to end. -Christine Mason Miller", "The pain you feel today will be the strength you feel tomorrow.", "Everyone wants to live on top of the mountain, but all the happiness and growth occurs while you’re climbing it. - Andy Rooney", "It is better to make many small steps in the right direction than to make a great leap forward only to stumble backward.", "Never give up on a dream just because of the time it will take to accomplish it. Time will pass anyway. – Earl Nightingale", "If you don’t like something, change it. If you can’t change it, change your attitude. Don’t complain.", "Can you remember who you were, before the world told you who you should be? - Danielle LaPorte", "You can’t use up creativity. The more you use, the more you have. - Maya Angelou", "The scariest moment is just before you start. - Stephen King"]


    
    // stores dailyTask information passed from category view
    var sentData1:String!
    var sentData2:String!
    var sentData3:String!
    var sentData4:String!
    var sentData5:String!
    var dailyTask = [String]()
    var monthlyGoals = [String]()
    var yearlyGoals = [String]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationItem.title = sentData5
            
            let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
            let dailyQuote = quotes[randomIndex] as String
            quoteBox.text = dailyQuote 
            
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

        // checks for completed tasks and adds strikethrough if they are completed
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
        
        for task in selectedTask {
            
            if task.isCompleted == true {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData1)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.textLabel?.attributedText =  attributeString
            }
        }
        // checks for completed monthly goals and adds strikethrough if completed
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

        
        let goalsToday = realm.objects(Goal.self).filter("createdAt BETWEEN %@", [monthStart, monthEnd])
        let monthGoals = goalsToday.filter("timeSpan = 'Month'")
        let selectedGoal = monthGoals.filter("desc = %@", self.sentData2)
        
        for goal in selectedGoal {
            
            if goal.isCompleted == true {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData2)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                cell.textLabel?.attributedText =  attributeString
            }
        }
        
        // checks for completed yearly goals and adds strikethrough if completed
        
        let yearEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        
        let yearStart: Date = {
            var components = DateComponents()
            components.day = -365
            components.second = -1
            return Calendar.current.date(byAdding: components, to: yearEnd)!
        }()
        
        let yearlyGoals = realm.objects(Goal.self).filter("createdAt BETWEEN %@", [yearStart, yearEnd])
        let yearGoal = yearlyGoals.filter("timeSpan = 'Year'")
        let selectedYGoal = yearGoal.filter("desc = %@", self.sentData3)
        
        for goal in selectedYGoal {
            
            if goal.isCompleted == true {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData3)
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
//        case 3:
//            cell.textLabel?.text = sentData4
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
            
            let realm = try! Realm()
            
            if indexPath.section == 0 {
                
                let todayStart = Calendar.current.startOfDay(for: Date() as Date)
                let todayEnd: Date = {
                    var components = DateComponents()
                    components.day = 1
                    components.second = -1
                    return Calendar.current.date(byAdding: components, to: todayStart)!
                }()
            
                let tasksToday = realm.objects(DailyTask.self).filter("createdAt BETWEEN %@", [todayStart, todayEnd])
                let selectedTask = tasksToday.filter("name = %@", self.sentData1)
                
                try! realm.write {
                    realm.delete(selectedTask)
                }
                self.performSegue(withIdentifier: "onDelete", sender: self)
            }
            
            else if indexPath.section == 1 {
                
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
                
                let goalsToday = realm.objects(Goal.self).filter("createdAt BETWEEN %@", [monthStart, monthEnd])
                let selectedGoal = goalsToday.filter("desc = %@", self.sentData2)
                
                try! realm.write {
                    realm.delete(selectedGoal)
                }
                self.performSegue(withIdentifier: "onDelete", sender: self)
                
            }
            
            else if indexPath.section == 2 {
                
                let startOfDay = Calendar.current.startOfDay(for: Date() as Date)
                
                
                let yearEnd: Date = {
                    var components = DateComponents()
                    components.day = 1
                    components.second = -1
                    return Calendar.current.date(byAdding: components, to: startOfDay)!
                }()
                
                let yearStart: Date = {
                    var components = DateComponents()
                    components.day = -365
                    components.second = -1
                    return Calendar.current.date(byAdding: components, to: yearEnd)!
                }()
                
                let yearlyGoals = realm.objects(Goal.self).filter("createdAt BETWEEN %@", [yearStart, yearEnd])
                let selectedYearlyGoal = yearlyGoals.filter("desc = %@", self.sentData3)
                
                try! realm.write {
                    realm.delete(selectedYearlyGoal)
                }
                self.performSegue(withIdentifier: "onDelete", sender: self)
            }
  
        }
        delete.backgroundColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)

        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
//            self.performSegue(withIdentifier: "editTasks", sender: self)
        }
        edit.backgroundColor = UIColor(red: 130/255, green: 208/255, blue: 216/255, alpha: 1.0)
        
        let markComplete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
            
            if indexPath.section == 0 {
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
                
                try! realm.write {
                    selectedTask.isCompleted = true
                    
                }
                if selectedTask.isCompleted == true {
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData1)
                    attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                    let cell = tableView.cellForRow(at: indexPath)
                    cell?.textLabel?.attributedText =  attributeString
                }
                let paths = [indexPath]
                tableView.reloadRows(at: paths, with: UITableViewRowAnimation.none)
            }
            
            else if indexPath.section == 1 {
                
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
                
                let goalsToday = realm.objects(Goal.self).filter("createdAt BETWEEN %@", [monthStart, monthEnd])
                let monthGoals = goalsToday.filter("timeSpan = 'Month'")
                let selectedGoal = monthGoals.filter("desc = %@", self.sentData2)[indexPath.row]
                
                try! realm.write {
                    selectedGoal.isCompleted = true
                    
                }
                if selectedGoal.isCompleted == true {
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData2)
                    attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                    let cell = tableView.cellForRow(at: indexPath)
                    cell?.textLabel?.attributedText =  attributeString
                }
                let paths = [indexPath]
                tableView.reloadRows(at: paths, with: UITableViewRowAnimation.none)

            }
            
            else if indexPath.section == 2 {
                
                let startOfDay = Calendar.current.startOfDay(for: Date() as Date)
                
                let yearEnd: Date = {
                    var components = DateComponents()
                    components.day = 1
                    components.second = -1
                    return Calendar.current.date(byAdding: components, to: startOfDay)!
                }()
                
                let yearStart: Date = {
                    var components = DateComponents()
                    components.day = -365
                    components.second = -1
                    return Calendar.current.date(byAdding: components, to: yearEnd)!
                }()
                let realm = try! Realm()
                
                let yearlyGoals = realm.objects(Goal.self).filter("createdAt BETWEEN %@", [yearStart, yearEnd])
                let yearGoal = yearlyGoals.filter("timeSpan = 'Year'")
                let selectedGoal = yearGoal.filter("desc = %@", self.sentData3)[indexPath.row]
            
                
                try! realm.write {
                    selectedGoal.isCompleted = true
                    
                }
                if selectedGoal.isCompleted == true {
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.sentData3)
                    attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                    let cell = tableView.cellForRow(at: indexPath)
                    cell?.textLabel?.attributedText =  attributeString
                }
                let paths = [indexPath]
                tableView.reloadRows(at: paths, with: UITableViewRowAnimation.none)
                
            }

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
    
  }
