/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import FBSDKCoreKit
import Parse
import CoreData

// If you want to use any of the UI components, uncomment this line
// import ParseUI

// If you want to use Crash Reporting - uncomment this line
// import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate { //NSManagerObject

    var window: UIWindow?

    //--------------------------------------
    // MARK: - UIApplicationDelegate
    //--------------------------------------

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //this is just added to connect application delegate
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        self.window?.backgroundColor = UIColor.purpleColor()
        
        // Enable storing and querying data from Local Datastore.
        // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
        Parse.enableLocalDatastore()

        // ****************************************************************************
        // Uncomment this line if you want to enable Crash Reporting
        // ParseCrashReporting.enable()
        //
        // Uncomment and fill in with your Parse credentials:
        Parse.setApplicationId("KcfFgVU9P4GbbEj1aY72j3EzrnRc8AsqjLbx3Ine",
            clientKey: "ECixTcPdzaQ6K13Orxo5fl2ft9ouChNW6VKLmVJ4")
        //
        // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
        // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
        // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
        // PFFacebookUtils.initializeFacebook()
        // ****************************************************************************

        PFUser.enableAutomaticUser()

        let defaultACL = PFACL();

        // If you would like all objects to be private by default, remove this line.
        defaultACL.setPublicReadAccess(true)

        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)

        if application.applicationState != UIApplicationState.Background {
            // Track an app open here if we launch with a push, unless
            // "content_available" was used to trigger a background push (introduced in iOS 7).
            // In that case, we skip tracking here to avoid double counting the app-open.

            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var noPushPayload = false;
            if let options = launchOptions {
                noPushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil;
            }
            if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        
//        func parseCSV (contentsOfURL: NSURL, encoding: NSStringEncoding, error: NSErrorPointer) -> [(name:String, type:String, distance:String, price: String)]? {
//            // Load the CSV file and parse it
//            let delimiter = ","
//            var items:[(name:String, type: String, distance:String, price: String)]?
//            let content: String
//           // if let content = String(contentsOfURL: contentsOfURL, encoding: encoding, error: error) {
//                items = []
//                let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
//                
//                for line in lines {
//                    var values:[String] = []
//                    if line != "" {
//                        // For a line with double quotes
//                        // we use NSScanner to perform the parsing
//                        if line.rangeOfString("\"") != nil {
//                            var textToScan:String = line
//                            var value:NSString?
//                            var textScanner:NSScanner = NSScanner(string: textToScan)
//                            while textScanner.string != "" {
//                                
//                                if (textScanner.string as NSString).substringToIndex(1) == "\"" {
//                                    textScanner.scanLocation += 1
//                                    textScanner.scanUpToString("\"", intoString: &value)
//                                    textScanner.scanLocation += 1
//                                } else {
//                                    textScanner.scanUpToString(delimiter, intoString: &value)
//                                }
//                                
//                                // Store the value into the values array
//                                values.append(value as! String)
//                                
//                                // Retrieve the unscanned remainder of the string
//                                //THIS IS PROBABLY WRONG
//                                if textScanner.scanLocation < textScanner.string.characters.count {
//                                    textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
//                                } else {
//                                    textToScan = ""
//                                }
//                                textScanner = NSScanner(string: textToScan)
//                            }
//                            
//                            // For a line without double quotes, we can simply separate the string
//                            // by using the delimiter (e.g. comma)
//                        } else  {
//                            values = line.componentsSeparatedByString(delimiter)
//                        }
//                        
//                        // Put the values into the tuple and add it to the items array
//                        let item = (name: values[0], type: values[1], distance: values[2], price: values[3])
//                        items?.append(item)
//                    }
//                }
//            //}
//            
//            return items
//        }
        
//        func preloadData () {
//            // Retrieve data from the source file
//            if let contentsOfURL = NSBundle.mainBundle().URLForResource("people", withExtension: "csv") {
//                
//                // Remove all the menu items before preloading
//                removeData()
//                
//                var error:NSError?
//                if let items = parseCSV(contentsOfURL, encoding: NSUTF8StringEncoding, error: &error) {
//                    // Preload the people items
//                    let managedObjectContext = self.managedObjectContext
//                    //let managedObjectContext = self.managedObjectContext {
//                        for item in items {
////                            let menuItem = NSEntityDescription.insertNewObjectForEntityForName("Place", inManagedObjectContext: managedObjectContext) as Place
//                            let entity =  NSEntityDescription.entityForName("Place",
//                                            inManagedObjectContext:managedObjectContext)
//                            
//                                        let placeitem = NSManagedObject(entity: entity!,
//                                            insertIntoManagedObjectContext: managedObjectContext) as 
//                                        placeitem.name = item.name
//                                        place1.setValue(15.00, forKey: "budget")
//                                        place1.setValue("Restaurant", forKey: "type")
//                            
//                            menuItem.name = item.name
//                            menuItem.detail = item.detail
//                            menuItem.price = (item.price as NSString).doubleValue
//                            
//                            if managedObjectContext.save(&error) != true {
//                                print("insert error: \(error!.localizedDescription)")
//                            }
//                        }
//                    }
//                }
//            }
//        
//        
//        func removeData () {
//            // Remove the existing items
//            if let managedObjectContext = self.managedObjectContext {
//                let fetchRequest = NSFetchRequest(entityName: "MenuItem")
//                var e: NSError?
//                let menuItems = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as! [MenuItem]
//                
//                if e != nil {
//                    println("Failed to retrieve record: \(e!.localizedDescription)")
//                    
//                } else {
//                    
//                    for menuItem in menuItems {
//                        managedObjectContext.deleteObject(menuItem)
//                    }
//                }
//            }
//        }

        //
        //  Swift 1.2
        //
        //        if application.respondsToSelector("registerUserNotificationSettings:") {
        //            let userNotificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        //            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        //            application.registerUserNotificationSettings(settings)
        //            application.registerForRemoteNotifications()
        //        } else {
        //            let types = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
        //            application.registerForRemoteNotificationTypes(types)
        //        }

        //
        //  Swift 2.0
        
//                if #available(iOS 8.0, *) {
//                    let types: UIUserNotificationType = [.Alert, .Badge, .Sound]
//                    let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
//                    application.registerUserNotificationSettings(settings)
//                    application.registerForRemoteNotifications()
//                } else {
//                    let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
//                    application.registerForRemoteNotificationTypes(types)
//                }

        return true
    }

    //--------------------------------------
    // MARK: Push Notifications
    //--------------------------------------

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()

        PFPush.subscribeToChannelInBackground("") { (succeeded: Bool, error: NSError?) in
            if succeeded {
                print("ParseStarterProject successfully subscribed to push notifications on the broadcast channel.\n");
            } else {
                print("ParseStarterProject failed to subscribe to push notifications on the broadcast channel with error = %@.\n", error)
            }
        }
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.\n")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
        }
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
        }
    }

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you want to use Push Notifications with Background App Refresh
    ///////////////////////////////////////////////////////////
    // func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    //     if application.applicationState == UIApplicationState.Inactive {
    //         PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
    //     }
    // }

    //--------------------------------------
    // MARK: Facebook SDK Integration
    //--------------------------------------

    ///////////////////////////////////////////////////////////
    // Uncomment this method if you are using Facebook
    ///////////////////////////////////////////////////////////
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        //return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication, session:PFFacebookUtils.session())
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.plymouthsoftware.core_data" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("DATAMODELNAME", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("PROJECTNAME.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although} it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func applicationWillTerminate(application: UIApplication){
        self.saveContext()
    }
}