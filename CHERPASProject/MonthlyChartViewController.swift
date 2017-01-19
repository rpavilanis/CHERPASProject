//
//  MonthlyChartViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/13/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

//@objc(BarChartFormatter)
//public class BarChartFormatter: NSObject, IAxisValueFormatter
//{
//    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
//    var category: [String]! = ["C", "H", "E", "R", "P", "A", "S"]
//    
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
//    {
//        return category[Int(value)]
//    }
//}


class MonthlyChartViewController: UIViewController {

    @IBOutlet weak var barBtn2: UIBarButtonItem!
    @IBOutlet weak var setMonthlyChart: BarChartView!

    //    var months: [String]!
    var cleanliness = [String]()
    var healthyEating = [String]()
    var exercise = [String]()
    var relationships = [String]()
    var personalDevelopment = [String]()
    var actionBasedLiving = [String]()
    var spirituality = [String]()
    var percentComplete = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTasks()
        //        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let category = [1, 2, 3, 4, 5, 6, 7]
        //        let percentComplete = [10, 70, 25, 60, 100, 50, 60]
        
        makeChart(dataPoints: category, values: percentComplete)
        //        updateChartWithData()
        // Do any additional setup after loading the view.
        barBtn2.target = revealViewController()
        barBtn2.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    
    func makeChart(dataPoints: [Int], values: [Int]) {
        setMonthlyChart.noDataText = "You don't yet have enough data to produce your weekly chart."
        
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        
        //        self.setMonthlyChart.xAxis.labelCount = self.months.count
        //        self.setMonthlyChart.xAxis.valueFormatter = DefaultAxisValueFormatter { (value, axis) -> String in return self.months[Int(value)] }
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Percentage Completed in Past Month")
        let chartData = BarChartData(dataSet: chartDataSet)
        //outlet from view
        setMonthlyChart.data = chartData
        setMonthlyChart.xAxis.valueFormatter = xaxis.valueFormatter
        
        setMonthlyChart.descriptionText = ""
        setMonthlyChart.xAxis.labelPosition = .bottom
        chartDataSet.colors = [UIColor(red: 255/255, green: 205/255, blue: 127/255, alpha: 1)]
        setMonthlyChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        //        setMonthlyChart.legend.colors = [UIColor(red: 255/255, green: 205/255, blue: 127/255, alpha: 1)]
        setMonthlyChart.legend.enabled = false
        setMonthlyChart.leftAxis.axisMaximum = 100
        setMonthlyChart.leftAxis.axisMinimum = 0
        setMonthlyChart.rightAxis.enabled = false
        setMonthlyChart.leftAxis.axisMinValue = 0
        setMonthlyChart.leftAxis.axisMaxValue = 100
        setMonthlyChart.xAxis.drawGridLinesEnabled = false
        
    }
    
    // will need a function to query data for past 7 days and sort by category - putting each into a variable so I can display it within graph
    
    
    
    func queryTasks() {
        
        let startOfDay = Calendar.current.startOfDay(for: Date() as Date)
        
        
        let monthEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        
        let monthStart: Date = {
            var components = DateComponents()
            components.day = -30
            components.second = -1
            return Calendar.current.date(byAdding: components, to: monthEnd)!
        }()
        
        
        let realm = try! Realm()
        
        let allTasks = realm.objects(DailyTask)
        let monthlyTasks = allTasks.filter("createdAt BETWEEN %@", [monthStart, monthEnd])
        var cIsC = Double()
        var cTotal = Double()
        var hIsC = Double()
        var hTotal = Double()
        var eIsC = Double()
        var eTotal = Double()
        var rIsC = Double()
        var rTotal = Double()
        var pIsC = Double()
        var pTotal = Double()
        var aIsC = Double()
        var aTotal = Double()
        var sIsC = Double()
        var sTotal = Double()
        
        
        for task in monthlyTasks{
            if task.category == "Cleanliness" {
                // assign 1 to isCompleted is true and 0 if false.  then take the total number of items in category, and divide total of trues by it to get percent complete.
                // within loop: add one to is completed and add 1 to total, then after loop, do calculations and assign to variables - then push values into array that I will use in project

                if task.isCompleted == true {
                    cIsC += 1
                    cTotal += 1
                }
                else {
                   cTotal += 1
                }
            }
            else if task.category == "Healthy Eating" {
                if task.isCompleted == true {
                    hIsC += 1
                    hTotal += 1
                }
                else {
                    hTotal += 1
                }
            }
            

            else if task.category == "Exercise" {
                if task.isCompleted == true {
                    eIsC += 1
                    eTotal += 1
                }
                else {
                    eTotal += 1
                }
            }
            else if task.category == "Relationships" {
                if task.isCompleted == true {
                    rIsC += 1
                    rTotal += 1
                }
                else {
                    rTotal += 1
                }
            }
            else if task.category == "Personal Development" {
                if task.isCompleted == true {
                    pIsC += 1
                    pTotal += 1
                }
                else {
                    pTotal += 1
                }
            }
            else if task.category == "Action-Based Living" {
                if task.isCompleted == true {
                    aIsC += 1
                    aTotal += 1
                }
                else {
                    aTotal += 1
                }
            }
            else if task.category == "Spirituality" {
                if task.isCompleted == true {
                    sIsC += 1
                    sTotal += 1
                }
                else {
                    sTotal += 1
                }
            }
        }
        
        
        let cPercent = (cIsC / cTotal) * 100
        let hPercent = (hIsC / hTotal) * 100
        let ePercent = (eIsC / eTotal) * 100
        let rPercent = (rIsC / rTotal) * 100
        let pPercent = (pIsC / pTotal) * 100
        let aPercent = (aIsC / aTotal) * 100
        let sPercent = (sIsC / sTotal) * 100
        
        percentComplete.append(Int(cPercent))
        percentComplete.append(Int(hPercent))
        percentComplete.append(Int(ePercent))
        percentComplete.append(Int(rPercent))
        percentComplete.append(Int(pPercent))
        percentComplete.append(Int(aPercent))
        percentComplete.append(Int(sPercent))

    }

    @IBAction func saveChart(_ sender: UIBarButtonItem) {
        print("Hello!")
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
}
