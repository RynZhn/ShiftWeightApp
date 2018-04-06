//
//  Setting.swift
//  AppleTableViewTutorial
//
//  Created by Ryan Zhan on 2/8/18.
//  Copyright © 2018 QL+. All rights reserved.
//

import Foundation
import os.log

class Scene: NSObject, NSCoding {
    var sceneName: String
    var notificationName: String
    var notificationDescription: String
    var timer: Int
    var onOff: Bool
    var silentSwitch: Bool
    
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("scenes")
    
    init(sceneName: String, notificationName: String, notificationDescription: String, timer: Int, onOff: Bool, silentSwitch: Bool){
        self.sceneName = sceneName
        self.notificationName = notificationName
        self.notificationDescription = notificationDescription
        self.timer = timer
        self.onOff = onOff
        self.silentSwitch = silentSwitch
    }
    
    //MARK: Types
    struct PropertyKey {
        static let sceneName = "sceneName"
        static let notificationName = "notificationName"
        static let notificationDescription = "notificationDescription"
        static let timer = "timer"
        static let onOff = "onOff"
        static let silentSwitch = "silentSwitch"
        
    }
    
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sceneName, forKey: PropertyKey.sceneName)
        aCoder.encode(notificationName, forKey: PropertyKey.notificationName)
        aCoder.encode(notificationDescription, forKey: PropertyKey.notificationDescription)
        aCoder.encode(timer, forKey: PropertyKey.timer)
        aCoder.encode(onOff, forKey: PropertyKey.onOff)
        aCoder.encode(silentSwitch, forKey: PropertyKey.silentSwitch)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let sceneName = aDecoder.decodeObject(forKey: PropertyKey.sceneName) as? String else{
            os_log("Unable to decode the name for Scene Object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let notificationName = aDecoder.decodeObject(forKey: PropertyKey.notificationName) as? String else{
            os_log("Unable to decode the notification name for Scene Object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let notificationDescription = aDecoder.decodeObject(forKey: PropertyKey.notificationDescription) as? String else{
            os_log("Unable to decode the description for Scene Object.", log: OSLog.default, type: .debug)
            return nil
        }
        let timer = aDecoder.decodeInteger(forKey: PropertyKey.timer)
        let onOff = aDecoder.decodeBool(forKey: PropertyKey.onOff)
        let silentSwitch = aDecoder.decodeBool(forKey: PropertyKey.silentSwitch)
        
        // Must call designated initializer.
        self.init(sceneName: sceneName, notificationName: notificationName, notificationDescription: notificationDescription, timer: timer, onOff: onOff, silentSwitch: silentSwitch)
    }
    
    
}

