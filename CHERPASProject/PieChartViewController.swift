//
//  PieChartViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/20/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

//@objc(PieChartFormatter)
//public class PieChartFormatter: NSObject, IAxisValueFormatter
//{
//    var category: [String]! = ["C", "H", "E", "R", "P", "A", "S"]
//    
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
//    {
//        return category[Int(value)]
//    }
//}


class PieChartViewController: UIViewController {

    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var saveChart: UIBarButtonItem!
    @IBOutlet weak var barBtn: UIBarButtonItem!
//    weak var axisFormatDelegate: IAxisValueFormatter?
    
    var cleanliness = [String]()
    var healthyEating = [String]()
    var exercise = [String]()
    var relationships = [String]()
    var personalDevelopment = [String]()
    var actionBasedLiving = [String]()
    var spirituality = [String]()
    var numComplete = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTasks()
        
        let category = [1, 2, 3, 4, 5, 6, 7]
        
        makeChart(dataPoints: category, values: numComplete)
        
        barBtn.target = revealViewController()
        barBtn.action = #selector(SWRevealViewController.revealToggle(_:))

        // Do any additional setup after loading the view.
    }

    @IBAction func saveChart(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    func makeChart(dataPoints: [Int], values: [Int]) {
        pieChartView.noDataText = "You don't yet have enough data to produce your weekly chart."
        
//        let formato:PieChartFormatter = PieChartFormatter()
//        let xaxis:XAxis = XAxis()
        
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
//            formato.stringForValue(Double(i), axis: xaxis)
        }
//        xaxis.valueFormatter = formato
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Number Completed")
//        let chartData = PieChartData(dataSet: chartDataSet)
//        pieChartView.data = chartData
//        pieChartView.xAxis.valueFormatter = xaxis.valueFormatter
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        
        
        chartDataSet.colors = colors
//         pieChartView.xAxis.valueFormatter = xaxis.valueFormatter
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChartView.data = chartData

        pieChartView.descriptionText = ""
        pieChartView.centerText = "Completed Task Totals"
    }
    
    
    
    func queryTasks() {
        
        let startOfDay = Calendar.current.startOfDay(for: Date() as Date)
        
        
        let yearEnd: Date = {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }()
        
        let yearStart: Date = {
            var components = DateComponents()
            components.day = -365
            components.second = -1
            return Calendar.current.date(byAdding: components, to: yearEnd)!
        }()
        
        
        let realm = try! Realm()
        
        let allTasks = realm.objects(DailyTask)
        let yearlyTasks = allTasks.filter("createdAt BETWEEN %@", [yearStart, yearEnd])
        var cIsC = Double()
        var hIsC = Double()
        var eIsC = Double()
        var rIsC = Double()
        var pIsC = Double()
        var aIsC = Double()
        var sIsC = Double()

        
        for task in yearlyTasks{
            if task.category == "Cleanliness" {
                if task.isCompleted == true {
                    cIsC += 1
                }
            }
            else if task.category == "Healthy Eating" {
                if task.isCompleted == true {
                    hIsC += 1
                }
            }
                
            else if task.category == "Exercise" {
                if task.isCompleted == true {
                    eIsC += 1
                }
            }
            else if task.category == "Relationships" {
                if task.isCompleted == true {
                    rIsC += 1
                }
            }
            else if task.category == "Personal Development" {
                if task.isCompleted == true {
                    pIsC += 1
                }
            }
            else if task.category == "Action-Based Living" {
                if task.isCompleted == true {
                    aIsC += 1
                }
            }
            else if task.category == "Spirituality" {
                if task.isCompleted == true {
                    sIsC += 1
                }
            }
        }
        
        
        
        numComplete.append(Int(cIsC))
        numComplete.append(Int(hIsC))
        numComplete.append(Int(eIsC))
        numComplete.append(Int(rIsC))
        numComplete.append(Int(pIsC))
        numComplete.append(Int(aIsC))
        numComplete.append(Int(sIsC))
        
    }

    
    
    
}
