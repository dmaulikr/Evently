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
import AVFoundation

class CreateEventViewController: UIViewController {
    let eventStore = EKEventStore()
    var calendars: [EKCalendar]?
    var budget: Int = 0
    var location: String = ""
    var name: String = ""
    var buttonSound : AVAudioPlayer?
    var eventTitle: String = ""
    var format: NSDateFormatter = NSDateFormatter()
//    self.format.dateFormat = "MM/dd/yyyy"
    
   // var eventDate: NSDate = format.dateFromString("12/11/2005")
//
    @IBOutlet weak var eventTime: UIDatePicker!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocation: UITextField!

//    @IBOutlet weak var eventDescription: UITextField!
//    @IBOutlet weak var eventDate: UITextField!
//    @IBOutlet weak var eventTime: UITextField!
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer? {
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer:AVAudioPlayer?
        
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        }
        catch{
            print("Player not availavle")
        }
        return audioPlayer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
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
                self.eventTitle = event.title /// just added to send title to home page
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
                        
                        if let buttonSound = self.setupAudioPlayerWithFile("ding", type: "wav"){
                            self.buttonSound = buttonSound
                        }
                        self.buttonSound?.play()
                        
                    })
                } catch {
                    // report error
                }
                
            } else {
                print("Need to get permission")
            }
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let toHome = segue.destinationViewController as! HomeViewController
        toHome.eventTitle = self.eventTitle
        toHome.recentSegue = "CreateEventViewController"
        toHome.address = self.location
        //toHome.distance = CLLocationDistance(distance.text!)!
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
