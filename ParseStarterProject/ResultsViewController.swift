//
//  ResultsViewController.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation



class ResultsViewController: UITableViewController, CLLocationManagerDelegate {

    var events = [Event]()
    var budget: Int = 0
    var distance: CLLocationDistance = 0
    let locationManager = CLLocationManager()
    //@IBOutlet var tableView: UITableView!
    //var places = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        title = "Your Suggested Events"
            super.viewDidLoad()
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            print("locationManager")
            
            if CLLocationManager.locationServicesEnabled(){
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
        }
        loadSampleEvents()
    }
    
    func loadSampleEvents(){
        let event1 = Event(name: "Lemongrass", location: "104 14th St NW, Charlottesville, VA", budget: 20, type: "R", coordinate: CLLocation(latitude: 38.035362, longitude: -78.498771))
        let event2 = Event(name: "Burtons Grill", location: "2010 Bond St, Charlottesville, VA", budget: 40, type: "R", coordinate: CLLocation(latitude: 38.064434, longitude: -78.490378 ))
        let event3 = Event(name: "Now and Zen", location: "202 2nd St NW, Charlottesville, VA", budget: 20, type: "R", coordinate: CLLocation(latitude: 38.032233, longitude: -78.4816263 ))
        let event4 = Event(name: "Jump Charlottesville", location: "1005 Gardens Blvd, Charlottesville, VA", budget: 20, type: "A", coordinate: CLLocation(latitude: 38.084743, longitude:-78.469688 ))
        let event5 = Event(name: "AMF Kegler's Lanes", location: "335 Rivanna Plaza Dr, Charlottesville, VA", budget: 20, type: "A", coordinate: CLLocation(latitude: 38.092537, longitude: -78.470342))
        let event6 = Event(name: "Regal Cinemas Stonefield 14 & IMAX", location: "1954 Swanson Dr, Charlottesville, VA 22901", budget: 30, type: "A", coordinate: CLLocation(latitude: 38.064978, longitude: -78.493151))
        let event7 = Event(name: "Humpback Rock", location: "5846 Blue Ridge Pkwy, Afton, VA", budget: 0, type: "F", coordinate: CLLocation(latitude: 37.962861, longitude: -78.899935))
        let event8 = Event(name: "Carter Mountain Orchard", location: "1435 Carters Mountain Trail, Charlottesville, VA 22901", budget: 0, type: "F", coordinate: CLLocation(latitude: 37.991732, longitude: -78.471662))
        
        
        
        //conditionally append events if they are within the user's budget
        if(event1?.budget <= budget){
            let meters: CLLocationDistance = (event1?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            print("miles",miles)
            if(miles <= distance){
            events.append(event1!)
            }
        }
        if(event2?.budget <= budget){
            let meters: CLLocationDistance = (event2?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            if(miles <= distance){
                events.append(event2!)
            }
        }
        if(event3?.budget <= budget){
            let meters: CLLocationDistance = (event3?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            if(miles <= distance){
                events.append(event3!)
            }
        }
        if(event4?.budget <= budget){
            let meters: CLLocationDistance = (event4?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            if(miles <= distance){
                events.append(event4!)
            }
        }
        if(event5?.budget <= budget){
            let meters: CLLocationDistance = (event5?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            if(miles <= distance){
                events.append(event5!)
            }
        }
        if(event6?.budget <= budget){
            let meters: CLLocationDistance = (event6?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            if(miles <= distance){
                events.append(event6!)
            }        }
        if(event7?.budget <= budget){
            let meters: CLLocationDistance = (event7?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            if(miles <= distance){
                events.append(event7!)
            }        }
        if(event8?.budget <= budget){
            let meters: CLLocationDistance = (event8?.coordinate.distanceFromLocation(locationManager.location!))!
            let miles = meters/1609.34
            if(miles <= distance){
                events.append(event8!)
            }
        }
        
    }
    
    func locationChange(newLocation: CLLocation, oldLocation: CLLocation){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)-&gt;)
        //            if error{
        //                println("Reverse geocoder failed with error"
        //            }
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        // let locValue2:CLLocationCoordinate2D = manager.location!
        
        //  var geocoder: CLGeocoder = CLGeocoder()
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        //  locationLabel.text = "locations = \(locValue.latitude) \(locValue.longitude)"
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
