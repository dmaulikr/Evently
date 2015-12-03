//
//  SignUpInViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Vanessa Dyce on 10/18/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import CoreData
import Firebase

class SignUpInViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func signUp(sender: AnyObject) {
        //if #available(iOS 8.0, *) {
//            let alertController = UIAlertController(title: "Agree to terms and conditions", message: "Click I AGREE to signal that you aree to the End User License Agreement.", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alertController.addAction(UIAlertAction(title: "I AGREE", style: UIAlertActionStyle.Default, handler: {alertController in self.processSignUp()})
//            )
//            alertController.addAction(UIAlertAction(title: "I do NOT agree", style: UIAlertActionStyle.Default, handler: nil)
//            )
//            
//            //Display alert
//            self.presentViewController(alertController, animated: true, completion: nil)
//            
        processSignUp()
        //}
        
    }
    
    func processSignUp(){
        
        print("processing signup")
        var userEmail = email.text
        let userPassword = password.text
        
//        let newPerson: NSEntityDescription.entityForName;("Person", inManagedObjectContext:self.managedObjectContext,
//        NSManagedObject(entity: Person, insertIntoManagedObjectContext: self.managedObjectContext)
//        newPerson.setValue("Jim", forKey: "first")
//        var children: NSMutableSet = newPerson.mutableSetValueForKey("children")
//        children.addObject(newPerson)
        
        // ensure username is lowercase
        userEmail = userEmail?.lowercaseString
        
        // start activity indicator
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        // Create the user
        let user = PFUser()
        user.username = userEmail
        user.password = userPassword
        user.email = userEmail
        
        user.signUpInBackgroundWithBlock{
            (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                
                dispatch_async(dispatch_get_main_queue()){
                    self.performSegueWithIdentifier("signInToNavigation", sender: self)
                }
                
        } else { 
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
                
            
            if let _: AnyObject = error!.userInfo["error"] {
                dispatch_async(dispatch_get_main_queue(), {
                    let alert: UIAlertView = UIAlertView(title: "Email Taken", message: "This user is already registered", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                    
                })
                }
       }
        
    }
}
    
    @IBAction func signIn(sender: AnyObject) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        var userEmail = email.text
        userEmail = userEmail?.lowercaseString
        
        let userPassword = password.text
        
        PFUser.logInWithUsernameInBackground(userEmail!, password:userPassword!) {
            (user: PFUser?, error:NSError?) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("signInToNavigation", sender: self)
                }
            } else {
                self.activityIndicator.stopAnimating()
                
                if let _: AnyObject = error!.userInfo["error"] {
                    dispatch_async(dispatch_get_main_queue(), {
                        let alert: UIAlertView = UIAlertView(title: "Invalid Login", message: "Incorrect email or password", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                        
                        
                    })
                   
                }
            }
        }
        
    }
    
    @IBAction func signOut(sender: AnyObject){
        
        PFUser.logOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpInViewController") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func dismissKeyboard(){
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()
        let loginButton: FBSDKLoginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
       

        
        //tap gesture
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
//    
//    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
//        super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
//        // = toInterfaceOrientation
//        
//        self.setupViewsForOrientation(toInterfaceOrientation)
//    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true

        // Dispose of any resources that can be recreated.
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
