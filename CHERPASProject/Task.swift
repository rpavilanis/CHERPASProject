//
//  Task.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/3/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import Foundation

import RealmSwift

// Model

final class Category: Object {
    dynamic var name = ""
//    dynamic var id = ""
    let tasks = List<DailyTask>()
    let monthlyGoals = List<MonthlyGoal>()
    let yearlyGoals = List<YearlyGoal>()
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}

final class DailyTask: Object {
    dynamic var taskId = NSUUID().uuidString
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    dynamic var isCompleted = false
    
    override class func primaryKey() -> String? {
        return "taskId"
    }
    
    override class func indexedProperties() -> [String] {
        return ["done"]
    }
}

final class MonthlyGoal: Object {
    dynamic var desc = ""
    dynamic var createdAt = NSDate()
    dynamic var isCompleted = false
}


final class YearlyGoal: Object {
    dynamic var desc = ""
    dynamic var createdAt = NSDate()
    dynamic var isCompleted = false
}


