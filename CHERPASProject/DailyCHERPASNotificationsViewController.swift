//
//  DailyCHERPASNotificationsViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/13/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit

class DailyCHERPASNotificationsViewController: UIViewController {
    

    @IBOutlet weak var barBtn3: UIBarButtonItem!
    @IBAction func datePickerDidSelectNewDate(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.scheduleNotification(at: selectedDate)
    }
    
    override func viewDidLoad() {
        barBtn3.target = revealViewController()
        barBtn3.action = #selector(SWRevealViewController.revealToggle(_:))
    }
}
