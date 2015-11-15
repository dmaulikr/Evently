//
//  CreateEventViewController.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 10/27/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class CreateEventViewController: UIViewController {
    let eventStore = EKEventStore()
    var calendars: [EKCalendar]?

    //@IBOutlet weak var eventName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       // dismissKeyboard()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    @IBAction func makeEvent(sender: AnyObject){
        let store = EKEventStore()
        store.requestAccessToEntityType(EKEntityType.Event, completion: {(accessGranted:Bool, error: NSError?) in
            if accessGranted == true {
                let event = EKEvent(eventStore: store)
                event.title = "Event Title"
                event.startDate = NSDate() //today
                event.endDate = event.startDate.dateByAddingTimeInterval(60*60) //1 hour long meeting
                event.calendar = store.defaultCalendarForNewEvents
                //let err: NSError?
                do {
                    //try store.saveEvent(event, span: EKSpan.ThisEvent)
                    try store.saveEvent(event, span: EKSpan.ThisEvent)
                    print("Saved Event")

                } catch {
                    // report error
                }
                
                //self.savedEventId = event.eventIdentifier //save event id to access this particular event later
            } else {
                print("Need to get permission")
            }
        })
    }
    
//    func dismissKeyboard(){
//        eventName.resignFirstResponder()
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
