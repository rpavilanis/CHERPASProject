//
//  SetMonthlyViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/13/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift


class SetMonthlyViewController: UIViewController {

 
    @IBOutlet weak var categoryLetter: UILabel!
    var categoryLetters = ["C", "H", "E", "R", "P", "A", "S"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SetMonthlyViewController.swipeGesture(sender:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(SetMonthlyViewController.swipeGesture(sender:)))
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
                self.performSegue(withIdentifier: "endMonthly", sender: self)
                break
            default:
                self.performSegue(withIdentifier: "endMonthly", sender: self)
                break
            }
        }
        
        if sender.direction == .up {
            
            self.performSegue(withIdentifier: "SetMonthly", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SetMonthly" {
            let GoalsView = (segue.destination as! GoalsViewController)
            // this function ensures the correct category is passed in with the manual segue that goes to the add form, which allows a task to be added to the correct category.
            
            let letter = categoryLetter.text!
            
            switch letter {
            case "C": GoalsView.passedCategory = "Cleanliness"
                break
            case "H": GoalsView.passedCategory = "Healthy Eating"
                break
            case "E": GoalsView.passedCategory = "Exercise"
                break
            case "R": GoalsView.passedCategory = "Relationships"
                break
            case "P": GoalsView.passedCategory = "Personal Development"
                break
            case "A": GoalsView.passedCategory = "Action-Based Living"
                break
            case "S": GoalsView.passedCategory = "Spirituality"
                break
            default: GoalsView.passedCategory = ""
                break
            }
        }
    }
}
