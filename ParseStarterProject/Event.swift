//
//  Event.swift
//  Evently-ios
//
//  Created by Vanessa Dyce on 11/16/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation



class Event : NSObject, NSCoding {
    //Properties
    var name: String
    var location: String
    var budget: Int
    var type: String
    
    //Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    //Types
    struct EventKey {
        static let nameKey = "name"
        static let locationKey = "location"
        static let budgetKey = "budget"
        static let typeKey = "type"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: EventKey.nameKey)
        aCoder.encodeObject(location, forKey: EventKey.locationKey)
        aCoder.encodeInteger(budget, forKey: EventKey.budgetKey)
        aCoder.encodeObject(type, forKey: EventKey.typeKey)
    }
    
    init?(name: String, location: String, budget: Int, type: String){
        self.name = name
        self.location = location
        self.budget = budget
        self.type = type
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(EventKey.nameKey) as! String
        let location = aDecoder.decodeObjectForKey(EventKey.locationKey) as! String
        let budget = aDecoder.decodeIntegerForKey(EventKey.budgetKey)
        let type = aDecoder.decodeObjectForKey(EventKey.typeKey) as! String
        
        self.init(name: name, location: location, budget: budget, type: type)
        
    }
    
    
}