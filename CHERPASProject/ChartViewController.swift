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

@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter
{
    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var category: [String]! = ["C", "H", "E", "R", "P", "A", "S"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        return category[Int(value)]
    }   
}


class ChartViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var barBtn: UIBarButtonItem!
    @IBOutlet weak var setChart: BarChartView!
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
        let category = [1, 2, 3, 4, 5, 6, 7]


        makeChart(dataPoints: category, values: percentComplete)
        
        barBtn.target = revealViewController()
        barBtn.action = #selector(SWRevealViewController.revealToggle(_:))
    }
    
    @IBAction func saveChart(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }

 
    func makeChart(dataPoints: [Int], values: [Int]) {
        setChart.noDataText = "You don't yet have enough data to produce your weekly chart."
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Percentage Completed in last Week")
        let chartData = BarChartData(dataSet: chartDataSet)
        //outlet from view 
        setChart.data = chartData
        setChart.xAxis.valueFormatter = xaxis.valueFormatter
        
        setChart.descriptionText = ""
        setChart.xAxis.labelPosition = .bottom
        chartDataSet.colors = [UIColor(red: 255/255, green: 205/255, blue: 127/255, alpha: 1)]
        setChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        setChart.legend.enabled = false
        setChart.leftAxis.axisMaximum = 100
        setChart.leftAxis.axisMinimum = 0
        setChart.rightAxis.enabled = false
        setChart.leftAxis.axisMinValue = 0
        setChart.leftAxis.axisMaxValue = 100
        setChart.xAxis.drawGridLinesEnabled = false
        
    }

    func queryTasks() {
        
        let startOfDay = Calendar.current.startOfDay(for: Date() as Date)
        
        
        let weekEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        
        
        let weekStart: Date = {
            var components = DateComponents()
            components.day = -7
            components.second = -1
            return Calendar.current.date(byAdding: components, to: weekEnd)!
        }()
        
        
        let realm = try! Realm()
        
        let allTasks = realm.objects(DailyTask)
        print(allTasks)
        let weeklyTasks = allTasks.filter("createdAt BETWEEN %@", [weekStart, weekEnd])
        print(weeklyTasks)
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
        
        
        for task in weeklyTasks{
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
    
}

