//
//  HomeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Vanessa Dyce on 10/19/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import EventKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var findEventButton: UIBarButtonItem!
    @IBOutlet weak var searchForEventButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()

        self.userEmail.text = PFUser.currentUser()?.email

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func signOut(sender: AnyObject){
//        
//     PFUser.logOut()
//
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") as UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
//    }
    
    @IBAction func signOut(sender: AnyObject){
             PFUser.logOut()
        
        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") as UIViewController
                self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard(){
        eventTitle.resignFirstResponder()
    }
    
    @IBAction func createEvent(sender: AnyObject) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("CreateEventViewController") as UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
        
        self.performSegueWithIdentifier("createEventNavigation", sender: self)
    }
    
    @IBAction func makeEvent(sender: AnyObject){
        let store = EKEventStore()
        store.requestAccessToEntityType(EKEntityType.Event, completion: {(accessGranted:Bool, error: NSError?) in
            if accessGranted == true {
                let event = EKEvent(eventStore: store)
                let eventName = self.eventTitle.text
                event.title = eventName!
                event.startDate = NSDate() //today
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
                
                
                //self.savedEventId = event.eventIdentifier //save event id to access this particular event later
            } else {
                print("Need to get permission")
            }
        })
    }
    
//    @IBAction func findEvent(sender: AnyObject) {
//        dispatch_async(dispatch_get_main_queue()){
//            self.performSegueWithIdentifier("findEventNavigation", sender: self)
//        }
//    }
//    
//    @IBAction func searchForEvent(sender: AnyObject) {
//        dispatch_async(dispatch_get_main_queue()){
//            self.performSegueWithIdentifier("findEventNavigation", sender: self)
//        }
//    }
    
    
//    @IBAction func createEvent(sender: AnyObject) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("CreateEventViewController") as UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
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
