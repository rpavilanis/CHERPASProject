//
//  DailyCHERPASNotificationsViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/13/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit

class DailyCHERPASNotificationsViewController: UIViewController {

    @IBAction func datePickerDidSelectNewDate(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.scheduleNotification(at: selectedDate)
    }
}
