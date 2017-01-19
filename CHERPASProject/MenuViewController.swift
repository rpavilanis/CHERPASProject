//
//  MenuViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/12/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var menuNameArr:Array = [String]()
    var iconImage: Array = [UIImage]()
    

    @IBOutlet weak var imgProfile: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuNameArr = ["Home", "Set Daily CHERPAS", "Set CHERPAS Goals", "Week in Review", "Month in Review", "Check-In Notification", "Check-Out Notification"]
        iconImage = [UIImage(named: "home")!, UIImage(named: "CHERPAS")!, UIImage(named: "CHERPAS")!, UIImage(named: "data")!, UIImage(named: "data")!, UIImage(named: "notifications")!, UIImage(named: "notifications")!]
        
        imgProfile.layer.borderColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0).cgColor
        
        imgProfile.layer.borderWidth = 2
        imgProfile.layer.cornerRadius = 50
        imgProfile.layer.masksToBounds = false
        imgProfile.clipsToBounds = true
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
        cell.imgIcon.image = iconImage[indexPath.row]
        cell.lblMenuName.text! = menuNameArr[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealViewController:SWRevealViewController = self.revealViewController()
        
        let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
  
        if cell.lblMenuName.text! == "Home" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        if cell.lblMenuName.text! == "Set Daily CHERPAS" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "SetDailyViewController") as! SetDailyViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        if cell.lblMenuName.text! == "Set CHERPAS Goals" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "SetMonthlyViewController") as! SetMonthlyViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }

        
        if cell.lblMenuName.text! == "Week in Review" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        if cell.lblMenuName.text! == "Month in Review" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "MonthlyChartViewController") as! MonthlyChartViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        if cell.lblMenuName.text! == "Check-In Notification" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "DailyCHERPASNotificationsViewController") as! DailyCHERPASNotificationsViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        if cell.lblMenuName.text! == "Check-Out Notification" {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "EndDailyCHERPASNotificationsViewController") as! EndDailyCHERPASNotificationsViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
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
