//
//  CategoriesViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/3/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    var categories = ["Cleanliness", "Healthy Eating", "Exercise", "Relationships", "Personal Development", "Action-Based Living", "Spirituality"]
    
    var dailyTasks = ["Clean bathroom", "Eat 3 servings of veggies", "Week 3, Day 1 of C25K", "Call Lila", "Read 30 minutes", "Do January budget", "Meditate 20 minutes - Headspace"]
    
    var monthlyGoals = ["Clean for 15 minutes each day.", "H Goal", "E Goal", "R Goal", "P Goal", "A Goal",
        "S Goal"]
    
    var yearlyGoals = ["At monthly check-ins, the apartment will be clean and organized due to gradual daily cleaning.", "H Goal", "E Goal", "R Goal", "P Goal", "A Goal","S Goal"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // This removes the label on the back bar - remove this if I want to add label back in for this.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        let categoryName = categories[indexPath.row]
        // this code works - but not enough space to include name and task detail - just want to display task
//        cell.textLabel?.text = categoryName
        cell.detailTextLabel?.text = dailyTasks[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)
        cell.textLabel?.text = categories[indexPath.row]
        cell.imageView?.image = UIImage(named: categoryName)
        
        return cell
    }

        
//        cell.textLabel?.text = "Category OR Daily Task"
//        cell.imageView?.image = UIImage(named: "first-image")
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        
//        switch indexPath.row{
//        case 0: self.performSegue(withIdentifier: "dayOverview", sender: self)
//        break
//        case 1: self.performSegue(withIdentifier: "H", sender: self)
//        break
//        case 2: self.performSegue(withIdentifier: "E", sender: self)
//        break
//        case 3: self.performSegue(withIdentifier: "R", sender: self)
//        break
//        case 4: self.performSegue(withIdentifier: "P", sender: self)
//        break
//        case 5: self.performSegue(withIdentifier: "A", sender: self)
//        break
//        case 6: self.performSegue(withIdentifier: "S", sender: self)
//        break
//        default:
//        break
//        }
//        
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dayOverview" {
            let dayOverview = segue.destination as! DayOverviewViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                let taskItem = dailyTasks[indexpath.row] as String
                dayOverview.sentData1 = taskItem
                
                let monthGoal = monthlyGoals[indexpath.row] as String
                dayOverview.sentData2 = monthGoal
                
                let yearGoal = yearlyGoals[indexpath.row] as String
                dayOverview.sentData3 = yearGoal
            }
        }

        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
