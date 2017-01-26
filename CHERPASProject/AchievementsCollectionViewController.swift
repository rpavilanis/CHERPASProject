//
//  CollectionViewController.swift
//  CHERPASProject
//
//  Created by Rachel Pavilanis on 1/23/17.
//  Copyright © 2017 Rachel Pavilanis. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "accomplishment"

class AchievementsCollectionViewController: UICollectionViewController {

    var completed = [String]()
    @IBOutlet weak var barBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTasks()
        
        collectionView!.contentInset = UIEdgeInsets(top: 40, left: 18, bottom: 5, right: 18)
        
        barBtn.target = revealViewController()
        barBtn.action = #selector(SWRevealViewController.revealToggle(_:))


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return completed.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AccomplishmentsCollectionViewCell
        
        // Make the cell blue.
        cell.backgroundColor = UIColor(red: 130/255, green: 208/255, blue: 216/255, alpha: 1.0)
    
        // Configure the cell
        cell.myLabel.text = completed[indexPath.item]
        cell.myLabel.textColor = UIColor(red: 27/255, green: 124/255, blue: 150/255, alpha: 1.0)
        cell.myLabel.sizeToFit()
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10

    
        return cell
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
        
        let allGoals = realm.objects(Goal)
        // will also need to add filter so that it includes only appropriate category as well
        let currentGoals = allGoals.filter("createdAt BETWEEN %@", [yearStart, yearEnd])
        for goal in currentGoals{
            if goal.isCompleted == true {
                completed.append(goal.desc)
            }
        }
        collectionView?.reloadData()
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
