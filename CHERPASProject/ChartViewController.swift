//
//  ChartViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/11/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ChartViewController: UIViewController {
    
    @IBOutlet weak var setChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        updateChartWithData()
        // Do any additional setup after loading the view.
    }
    
   
    
    //    func updateChartWithData() {
    //        var dataEntries: [BarChartDataEntry] = []
    //        let tasksByCategory = getTasksByCategoryFromDatabase()
    //        for i in 0..<visitorCounts.count {
    //            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(visitorCounts[i].count))
    //            dataEntries.append(dataEntry)
    //        }
    //        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
    //        let chartData = BarChartData(dataSet: chartDataSet)
    //        barView.data = chartData
    //    }
    //
    //    func getTasksByCategoryFromDatabase() -> Results<DailyTask> {
    //        do {
    //            let realm = try Realm()
    //            return realm.objects(VisitorCount.self)
    //        } catch let error as NSError {
    //            fatalError(error.localizedDescription)
    //        }
    //    }
    
    
    
    
}

