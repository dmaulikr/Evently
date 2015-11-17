//
//  ResultsViewController.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import CoreData



class ResultsViewController: UITableViewController {

    var events = [Event]()
    var budget: Int = 0
    var distance: Int = 0
    //@IBOutlet var tableView: UITableView!
    //var places = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Suggested Events"
        loadSampleEvents()
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
        
        //conditionally append events if they are within the user's budget
        if(event1?.budget <= budget){
            events.append(event1!)
        }
        if(event2?.budget <= budget){
            events.append(event2!)
        }
        if(event3?.budget <= budget){
            events.append(event3!)
        }
        if(event4?.budget <= budget){
            events.append(event4!)
        }
        if(event5?.budget <= budget){
            events.append(event5!)
        }
        if(event6?.budget <= budget){
            events.append(event6!)
        }
        if(event7?.budget <= budget){
            events.append(event7!)
        }
        if(event8?.budget <= budget){
            events.append(event8!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "createEvent"){
            let toCreateEvent = segue.destinationViewController as! CreateEventViewController
            let indexPath: NSIndexPath = (tableView.indexPathForSelectedRow)!
            toCreateEvent.budget = events[indexPath.row].budget
            toCreateEvent.name = events[indexPath.row].name
            toCreateEvent.location = events[indexPath.row].location
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cellIdentifier = "EventTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
            //let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            
            let event = events[indexPath.row]
        
        cell.eventName.text = event.name
        cell.eventLocation.text = event.location
        cell.eventBudget.text = String(event.budget)
        
            //cell!.textLabel!.text = place.valueForKey("name") as? String
            
            return cell
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
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

}
