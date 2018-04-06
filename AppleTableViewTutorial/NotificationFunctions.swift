//
//  NotificationFunctions.swift
//  NotificationTest
//
//  Created by Ryan Zhan on 1/25/18.
//  Copyright © 2018 QL+. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationFunctions{
    
    func memes() -> Void {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "15 Second Notification", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Body", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: 65, repeats: true)
        let request = UNNotificationRequest(identifier: "fifteen", content: content, trigger: trigger )
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
    
    
    //function that can be called to create a custom notification request
    func setNotification(name:String, description:String,Cat:String,interval:Double, onOff:Bool, identifier:String){
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: name, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: description, arguments: nil)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = Cat
        
        //setting the type of notification trigger, this one is based on time
        //if you set repeats to true, time must be more than 60s because Apple  ¯\_(ツ)_/¯
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: onOff)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger )
        let center = UNUserNotificationCenter.current()
        
        //removes all previous notification requests
        center.removeAllPendingNotificationRequests()
        //adds the new request
        center.add(request, withCompletionHandler: nil)
    }
    
    //Notification with silent notification funcionality
    func setNotificationSound(name:String, description:String, interval:Double, onOff:Bool, identifier:String, silentOnOff:Bool ){
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: name, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: description, arguments: nil)
        
       
        if(silentOnOff){
            //code for silent notification
            content.sound = UNNotificationSound.init(named: "Silent.wav")
        } else{
            content.sound = UNNotificationSound.default()
        }
        content.sound = UNNotificationSound.default()
        
        //setting the type of notification trigger, this one is based on time
        //if you set repeats to true, time must be more than 60s because Apple  ¯\_(ツ)_/¯
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: onOff)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger )
        let center = UNUserNotificationCenter.current()
        
        //removes all previous notification requests
        center.removeAllPendingNotificationRequests()
        //adds the new request
        center.add(request, withCompletionHandler: nil)
    }
    
    //notifications only appear when app is in the background, can make it show up when app is in the forground if needed
    func test() -> Void {
        print("hey")
    }
    
    // clear all pending not
    func clearNotCenter(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    // request permission for notifications
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    
  
}
