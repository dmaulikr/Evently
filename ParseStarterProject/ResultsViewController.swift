//
//  ResultsViewController.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var places = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Oh The Places You'll Go\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            
            let place = places[indexPath.row]
            
            cell!.textLabel!.text = place.valueForKey("name") as? String
            
            return cell!
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
       // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       // let managedObjectContext = appDelegate.managedObjectContext

       
       //2
//        let entity =  NSEntityDescription.entityForName("Place",
//            inManagedObjectContext:managedContext)
//        
//        let place1 = NSManagedObject(entity: entity!,
//            insertIntoManagedObjectContext: managedContext)
//        place1.setValue("Lemongrass", forKey: "name")
//        place1.setValue(15.00, forKey: "budget")
//        place1.setValue("Restaurant", forKey: "type")
//        
//        //4
//        do {
//            try managedContext.save()
//            //5
//            places.append(place1)
//        } catch let error as NSError  {
//            print("Could not save \(error), \(error.userInfo)")
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: "Place")
//        
//        do {
//            let results =
//                try managedContext.executeFetchRequest(fetchRequest)
//            places = results as! [NSManagedObject]
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
