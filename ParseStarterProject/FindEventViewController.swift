//
//  FindEventViewController.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 11/4/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import CoreData

class FindEventViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    //@IBOutlet weak var locationLabel: UILabel!
    let locationManager = CLLocationManager()
    
    //@IBOutlet weak var eventName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        print("locationManager")

        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        // dismissKeyboard()
        
        
        // Do any additional setup after loading the view.
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
        locationLabel.text = "locations = \(locValue.latitude) \(locValue.longitude)"
    }
    
    
}