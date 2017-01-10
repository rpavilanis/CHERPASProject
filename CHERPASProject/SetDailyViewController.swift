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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            let letter = categoryLetter.text!
        
            switch letter {
            case "C":
                    self.performSegue(withIdentifier: "setDailySegue", sender: self)
                    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    let TasksView = (segue.destination as! TasksViewController)
                    TasksView.passedCategory = "Cleanliness"
                    }
                break
            case "H": self.performSegue(withIdentifier: "setDailySegue", sender: self)
                break
            case "E": self.performSegue(withIdentifier: "setDailySegue", sender: self)
                break
            case "R": self.performSegue(withIdentifier: "setDailySegue", sender: self)
                break
            case "P": self.performSegue(withIdentifier: "setDailySegue", sender: self)
                break
            case "A": self.performSegue(withIdentifier: "setDailySegue", sender: self)
                break
            case "S": self.performSegue(withIdentifier: "setDailySegue", sender: self)
                break
            default: self.performSegue(withIdentifier: "setDailySegue", sender: self)
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
