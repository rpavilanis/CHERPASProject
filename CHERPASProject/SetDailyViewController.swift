//
//  SetDailyViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/5/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit

class SetDailyViewController: UIViewController {

    @IBOutlet weak var categoryLetter: UILabel!
    var categoryLetters = ["C", "H", "E", "R", "P", "A", "S"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SetDailyViewController.swipeGesture(sender:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(SetDailyViewController.swipeGesture(sender:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        // Do any additional setup after loading the view.
    }
    
    func swipeGesture(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            let letter = categoryLetter.text!
            switch letter {
            case "C": categoryLetter.text = "H"
                break
            case "H": categoryLetter.text = "E"
                break
            case "E": categoryLetter.text = "R"
                break
            case "R": categoryLetter.text = "P"
                break
            case "P": categoryLetter.text = "A"
                break
            case "A": categoryLetter.text = "S"
                break
            case "S":
                self.performSegue(withIdentifier: "endDaily", sender: self)
                break
            default:
                self.performSegue(withIdentifier: "endDaily", sender: self)
                break
            }
        }
        
        if sender.direction == .up {
            
            self.performSegue(withIdentifier: "setDailySegue", sender: self)
                    
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "setDailySegue" {
            let TasksView = (segue.destination as! TasksViewController)
            // this function ensures the correct category is passed in with the manual segue that goes to the add form, which allows a task to be added to the correct category.
            
            let letter = categoryLetter.text!
            
            switch letter {
            case "C": TasksView.passedCategory = "Cleanliness"
                break
            case "H": TasksView.passedCategory = "Healthy Eating"
                break
            case "E": TasksView.passedCategory = "Exercise"
                break
            case "R": TasksView.passedCategory = "Relationships"
                break
            case "P": TasksView.passedCategory = "Personal Development"
                break
            case "A": TasksView.passedCategory = "Action-Based Living"
                break
            case "S": TasksView.passedCategory = "Spirituality"
                break
            default: TasksView.passedCategory = ""
                break
            }
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
