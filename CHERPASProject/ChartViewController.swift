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
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let category = [1, 2, 3, 4, 5, 6, 7]
        let percentComplete = [10, 70, 25, 60, 100, 50, 60]
        
        makeChart(dataPoints: category, values: percentComplete)
        //        updateChartWithData()
        // Do any additional setup after loading the view.
    }
    
 
    func makeChart(dataPoints: [Int], values: [Int]) {
        setChart.noDataText = "You don't yet have enough data to produce your weekly chart."
        
//        self.setChart.xAxis.labelCount = self.months.count
//        self.setChart.xAxis.valueFormatter = DefaultAxisValueFormatter { (value, axis) -> String in return self.months[Int(value)] }
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Percentage Completed in last Week")
        let chartData = BarChartData(dataSet: chartDataSet)
        //outlet from view 
        setChart.data = chartData
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

