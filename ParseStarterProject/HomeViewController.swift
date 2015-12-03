//
//  HomeViewController.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 12/2/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController{
    var eventTitle = String()
    var savedEvents = [Event]()
    var recentSegue = String()
    var address = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(recentSegue == "CreateEventViewController"){
            let newEvent = Event(name: eventTitle, location: address)
            self.savedEvents.append(newEvent!)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedEvents.count
    }
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        //let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! EventTableViewCell
        
       

        
        //cell.eventName.text = String(self.eventTitle)
        cell.eventName.text = String(savedEvents[indexPath.row].location as NSString)
        //cell.eventLocation.text = String(events2[indexPath.row]["location"] as! NSString)
        //cell.eventBudget.text = String(events2[indexPath.row]["budget"]!)

        //cell!.textLabel!.text = place.valueForKey("name") as? String
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
