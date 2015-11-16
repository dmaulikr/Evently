//
//  ResultsViewController.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import CoreData



class ResultsViewController: UIViewController, UTTableViewController, UITableViewDataSource{

    var events = [Event]()
    @IBOutlet var tableView: UITableView!
    var places = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"Oh The Places You'll Go\""
        loadSampleEvents()
        
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }
    
    func loadSampleEvents(){
        let event1 = Event(name: "Lemongrass", location: "104 14th St NW, Charlottesville, VA", budget: 20, type: "R")
        let event2 = Event(name: "Burtons Grill", location: "2010 Bond St, Charlottesville, VA", budget: 40, type: "R")
        let event3 = Event(name: "Now and Zen", location: "202 2nd St NW, Charlottesville, VA", budget: 20, type: "R")
        let event4 = Event(name: "Jump Charlottesville", location: "1005 Gardens Blvd, Charlottesville, VA", budget: 20, type: "A")
        let event5 = Event(name: "AMF Kegler's Lanes", location: "335 Rivanna Plaza Dr, Charlottesville, VA", budget: 20, type: "A")
        let event6 = Event(name: "Regal Cinemas Stonefield 14 & IMAX", location: "1954 Swanson Dr, Charlottesville, VA 22901", budget: 30, type: "A")
        let event7 = Event(name: "Humpback Rock", location: "5846 Blue Ridge Pkwy, Afton, VA", budget: 0, type: "F")
        let event8 = Event(name: "Carter Mountain Orchard", location: "1435 Carters Mountain Trail, Charlottesville, VA 22901", budget: 0, type: "F")
        events.append(event1!)
        events.append(event2!)
        events.append(event3!)
        events.append(event4!)
        events.append(event5!)
        events.append(event6!)
        events.append(event7!)
        events.append(event8!)
        
        //events += [event1, event2, event3, event4, event5, event6, event7, event8]

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
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
    
    

    
    func saveEvents(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save events...")
        }
    }
    
    func loadEvents() -> [Event]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]
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
