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

//final class Category: Object {
//    dynamic var name = ""
//    dynamic var id = NSUUID().uuidString
//    // a category has many tasks
//    let tasks = List<DailyTask>()
////    let goals = List<Goal>()
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}

final class DailyTask: Object {
    dynamic var taskId = NSUUID().uuidString
    dynamic var name = ""
    dynamic var category = ""
    dynamic var createdAt = NSDate()
    dynamic var isCompleted = false
    // a task belongs to one category
//    dynamic var category: Category?
    let goals = List<Goal>()
    
    override class func primaryKey() -> String? {
        return "taskId"
    }
    
//    override class func indexedProperties() -> [String] {
//        return ["done"]
//    }
}

final class Goal: Object {
    dynamic var goalId = NSUUID().uuidString
    dynamic var desc = ""
    dynamic var createdAt = NSDate()
    dynamic var isCompleted = false
    // will be month or year
    dynamic var timeSpan = ""
    // a goal belongs to one category
//    dynamic var category: Category?
    // a goal belongs to one task
    dynamic var task: DailyTask?
    override class func primaryKey() -> String? {
        return "goalId"
    }
}






