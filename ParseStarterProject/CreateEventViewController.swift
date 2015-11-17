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
    var budget: Int = 0
    var location: String = ""
    var name: String = ""
//
    @IBOutlet weak var eventTime: UIDatePicker!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocation: UITextField!

//    @IBOutlet weak var eventDescription: UITextField!
//    @IBOutlet weak var eventDate: UITextField!
//    @IBOutlet weak var eventTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("the selected name is:", name)
        eventName.text = name;
        eventLocation.text = location
        // dismissKeyboard()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    @IBAction func makeEvent(sender: AnyObject){
//        let store = EKEventStore()
//        store.requestAccessToEntityType(EKEntityType.Event, completion: {(accessGranted:Bool, error: NSError?) in
//            if accessGranted == true {
//                let event = EKEvent(eventStore: store)
//                event.title = "Event Title"
//                event.startDate = NSDate() //today
//                event.endDate = event.startDate.dateByAddingTimeInterval(60*60) //1 hour long meeting
//                event.calendar = store.defaultCalendarForNewEvents
//                //let err: NSError?
//                do {
//                    //try store.saveEvent(event, span: EKSpan.ThisEvent)
//                    try store.saveEvent(event, span: EKSpan.ThisEvent)
//                    print("Saved Event")
//
//                } catch {
//                    // report error
//                }
//                
//                //self.savedEventId = event.eventIdentifier //save event id to access this particular event later
//            } else {
//                print("Need to get permission")
//            }
//        })
//    }
    @IBAction func makeEvent(sender: AnyObject){
        let store = EKEventStore()
        store.requestAccessToEntityType(EKEntityType.Event, completion: {(accessGranted:Bool, error: NSError?) in
            if accessGranted == true {
                let event = EKEvent(eventStore: store)
                let nameOfEvent = self.eventName.text
                event.title = nameOfEvent!
                event.startDate = self.eventTime.date
                event.endDate = event.startDate.dateByAddingTimeInterval(60*60) //1 hour long meeting
                event.calendar = store.defaultCalendarForNewEvents
                //let err: NSError?
                do {
                    //try store.saveEvent(event, span: EKSpan.ThisEvent)
                    try store.saveEvent(event, span: EKSpan.ThisEvent)
                    print("Saved Event")
                    dispatch_async(dispatch_get_main_queue(), {
                        let alert: UIAlertView = UIAlertView(title: "Event Saved", message: "You have saved an event to your calendar!", delegate: nil, cancelButtonTitle: "Wahoowa")
                        alert.show()
                    })
                } catch {
                    // report error
                }
                
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
