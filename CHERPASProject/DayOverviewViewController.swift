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

    let items = [["Clean the kitchen"], ["Clean for 15 minutes each day."], ["At monthly check-ins, the apartment will be clean and organized due to gradual daily cleaning."], ["Our goals can only be reached through a vehicle of a plan, in which we must fervently believe and upon which we must vigorously act. There is no other route to success."]]

    
    // stores dailyTask information passed from category view
    var sentData1:String!
    var sentData2:String!
    var sentData3:String!
    var sentData4:String!
    var sentData5:String!
    var dailyTask = [String]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            queryTasks()
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationItem.title = sentData5
            
//            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(DayOverviewViewController.didSwipe(gestureRecognizer:)))
//            self.view.addGestureRecognizer(swipeLeft)

            
            
            
            
//            tableView.backgroundColor = UIColor.black
//            
            
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source
    
//    func didSwipe(gestureRecognizer:UIGestureRecognizer) {
//        
//        if gestureRecognizer.state == UIGestureRecognizerState.ended {
//            let swipeLocation = gestureRecognizer.location(in: self.tableView)
//            if let swipedIndexPath = self.tableView.indexPathForRow(at: swipeLocation){
//                if self.tableView.cellForRow(at: swipedIndexPath) != nil{
//                    print(swipedIndexPath)
//                    
//                    
//                }
//            }
//        }
//    }
    
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

         //Configure the cell...
//        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
//        
////        cell.textLabel?.textColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)
//
//        return cell
        switch (indexPath.section)
        {
        case 0:
            cell.textLabel?.text = dailyTask[indexPath.row]
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        super.tableView(tableView, editActionsForRowAt: indexPath)
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
//            print("delete button tapped")
            let todayStart = Calendar.current.startOfDay(for: Date() as Date)
            let todayEnd: Date = {
                var components = DateComponents()
                components.day = 1
                components.second = -1
                return Calendar.current.date(byAdding: components, to: todayStart)!
            }()
            let realm = try! Realm()
            let allTasks = realm.objects(DailyTask)
            let currentTask = allTasks.filter("createdAt BETWEEN %@", [todayStart, todayEnd])
//            currently this works to delete targeted object, HOWEVER - then my array shifts and things move around.
            try! realm.write {
                realm.delete(currentTask[indexPath.row])
            }
        }
        delete.backgroundColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)

        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("edit button tapped")
        }
        edit.backgroundColor = UIColor(red: 130/255, green: 208/255, blue: 216/255, alpha: 1.0)
        
        // need to adjust this with if statement once add in model - if task is complete already, need to be able to change to incomplete
        let markComplete = UITableViewRowAction(style: .normal, title: "Complete") { action, index in
            print(indexPath)
//            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: message)
//            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
//            
//            cell.textLabel?.attributedText =  attributeString
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
        // you need to implement this method too or you can't swipe to display the actions
    }
    
//     not working - can see delete but not deleting anything.  Need to make it so that quotes can't be deleted.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("Hello - delete happening!")
//            // this is where I would remove from database
//            //            objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            print("Hello!")
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
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
            dailyTask.append(task.name)
        
        tableView.reloadData()
        }
        
    }
    

}
