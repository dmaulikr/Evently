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
import Firebase



class ResultsViewController: UITableViewController, CLLocationManagerDelegate {

    var events = [Event]()
    var events2 = [NSDictionary]()
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
//        let event1 = Event(name: "Lemongrass", location: "104 14th St NW, Charlottesville, VA", budget: 20, type: "R", coordinate: CLLocation(latitude: 38.035362, longitude: -78.498771))
//        let event2 = Event(name: "Burtons Grill", location: "2010 Bond St, Charlottesville, VA", budget: 40, type: "R", coordinate: CLLocation(latitude: 38.064434, longitude: -78.490378 ))
//        let event3 = Event(name: "Now and Zen", location: "202 2nd St NW, Charlottesville, VA", budget: 20, type: "R", coordinate: CLLocation(latitude: 38.032233, longitude: -78.4816263 ))
//        let event4 = Event(name: "Jump Charlottesville", location: "1005 Gardens Blvd, Charlottesville, VA", budget: 20, type: "A", coordinate: CLLocation(latitude: 38.084743, longitude:-78.469688 ))
//        let event5 = Event(name: "AMF Kegler's Lanes", location: "335 Rivanna Plaza Dr, Charlottesville, VA", budget: 20, type: "A", coordinate: CLLocation(latitude: 38.092537, longitude: -78.470342))
//        let event6 = Event(name: "Regal Cinemas Stonefield 14 & IMAX", location: "1954 Swanson Dr, Charlottesville, VA 22901", budget: 30, type: "A", coordinate: CLLocation(latitude: 38.064978, longitude: -78.493151))
//        let event7 = Event(name: "Humpback Rock", location: "5846 Blue Ridge Pkwy, Afton, VA", budget: 0, type: "F", coordinate: CLLocation(latitude: 37.962861, longitude: -78.899935))
//        let event8 = Event(name: "Carter Mountain Orchard", location: "1435 Carters Mountain Trail, Charlottesville, VA 22901", budget: 0, type: "F", coordinate: CLLocation(latitude: 37.991732, longitude: -78.471662))
        let rootRef =  Firebase(url: "https://evently-app.firebaseio.com")
        rootRef.observeEventType(.Value, withBlock: {
            snapshot in
            //            print("\(snapshot.value["Lemongrass"][0])")
//            print(snapshot.children.nextObject()!)
            let event1 = snapshot.value["Lemongrass"] as! NSDictionary
            event1["budget"]!
            if(Int(event1["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event1["latitude"]! as! NSNumber), longitude: Double(event1["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event1)
                }
            }
            
            let event2 = snapshot.value["Burtons Grill"] as! NSDictionary
            event2["budget"]!
            if(Int(event2["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event2["latitude"]! as! NSNumber), longitude: Double(event2["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event2)
                }
            }
            
            
            let event3 = snapshot.value["Now and Zen"] as! NSDictionary
            event3["budget"]!
            if(Int(event3["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event3["latitude"]! as! NSNumber), longitude: Double(event3["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event3)
                }
            }
            
            
            let event4 = snapshot.value["Jump Charlottesville"] as! NSDictionary
            event4["budget"]!
            if(Int(event4["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event4["latitude"]! as! NSNumber), longitude: Double(event4["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event4)
                }
            }
            
            let event5 = snapshot.value["AMF Kegler's Lane"] as! NSDictionary
            event5["budget"]!
            if(Int(event5["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event5["latitude"]! as! NSNumber), longitude: Double(event5["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event5)
                }
            }
            
            let event6 = snapshot.value["Regal Cinemas Stonefield 14 & IMAX"] as! NSDictionary
            event6["budget"]!
            if(Int(event6["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event6["latitude"]! as! NSNumber), longitude: Double(event6["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event6)
                }
            }
            
            
            
            let event7 = snapshot.value["Humpback Rock"] as! NSDictionary
            event7["budget"]!
            if(Int(event7["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event7["latitude"]! as! NSNumber), longitude: Double(event7["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event7)
                }
            }
            
            
            let event8 = snapshot.value["Carter Mountain Orchard"] as! NSDictionary
            event8["budget"]!
            if(Int(event8["budget"]! as! NSNumber) <= self.budget){
                let location: CLLocation = CLLocation(latitude: Double(event8["latitude"]! as! NSNumber), longitude: Double(event8["longitude"]! as! NSNumber))
                let meters: CLLocationDistance = (location.distanceFromLocation(self.locationManager.location!))
                let miles = meters/1609.34
                if(miles <= self.distance){
                    self.events2.append(event8)
                }
            }
            print(self.events2)
            
        })
        
        
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
            toCreateEvent.budget = Int(events2[indexPath.row]["budget"] as! NSNumber)
            toCreateEvent.name = String(events2[indexPath.row]["name"] as! NSString)
            toCreateEvent.location = String(events2[indexPath.row]["location"] as! NSString)
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events2.count
    }

    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cellIdentifier = "EventTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
            //let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            
            //let event = events2[indexPath.row]
        
        cell.eventName.text = String(events2[indexPath.row]["name"] as! NSString)
        cell.eventLocation.text = String(events2[indexPath.row]["location"] as! NSString)
        cell.eventBudget.text = String(events2[indexPath.row]["budget"]!)
        
            //cell!.textLabel!.text = place.valueForKey("name") as? String
            
            return cell
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
    }
    
    func saveEvents(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events2, toFile: Event.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save events...")
        }
    }
    
    func loadEvents() -> [Event]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Event.ArchiveURL.path!) as? [Event]
    }

}
