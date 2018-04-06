//
//  MealTableViewController.swift
//  AppleTableViewTutorial
//
//  Created by Ryan Zhan on 2/8/18.
//  Copyright © 2018 QL+. All rights reserved.
//

import UIKit
import os.log
import UserNotifications


class SceneHomeViewController: UITableViewController,UNUserNotificationCenterDelegate {
    var scenes = [Scene]()
   
    private func loadSampleSettings(){
        
        let setting1 = Scene(sceneName: "Home", notificationName: "Home Notification", notificationDescription: "Home Description", timer: 60, onOff: false, silentSwitch: false)
        let setting2 = Scene(sceneName: "Work", notificationName: "Work Notification", notificationDescription: "Work Description", timer: 60, onOff: false, silentSwitch: false)
        let setting3 = Scene(sceneName: "Class", notificationName: "Class Notification", notificationDescription: "Class Description", timer: 60, onOff: false, silentSwitch: false)
        scenes += [setting1,setting2,setting3]
    }
 
    @IBAction func switchHit(_ sender: UISwitch) {
        
        if (sender.isOn) {
            for(row, scene) in scenes.enumerated(){
                if row != sender.tag {
                    
                    scene.onOff = false
                }else{
                    scene.onOff = true
                    NotificationFunctions().setNotification(name: scene.notificationName, description: scene.notificationDescription, Cat: "alarm.category", interval: Double(scene.timer), onOff: false, identifier: scene.sceneName)
                    print("Notification sent")
                }
            }
            
            
        }else{
            scenes[sender.tag].onOff = false
            NotificationFunctions().clearNotCenter()
            print("Notification Disabled")
        }

        

            self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.none)



    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let savedScenes = loadScenes(){
            scenes += savedScenes
        } else {
            loadSampleSettings()
        }
         UNUserNotificationCenter.current().delegate = self
        setCatergories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func unwindToSceneList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            SceneEditViewController, let sceneHolder = sourceViewController.scene{
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                scenes[selectedIndexPath.row] = sceneHolder
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                
                //Add new scene
                let newIndexPath = IndexPath(row: scenes.count, section: 0)
                scenes.append(sceneHolder)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveScenes()

           
        }
        
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return scenes.count
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        let request = response.notification.request
        if identifier == "snooze"{
        
        }
    
        completionHandler()
    }
    func setCatergories(){
        
        // defining the
        let snoozeAction = UNNotificationAction(
            identifier: "snooze", //identify action
            title: "Snooze 5 Sec", //whats displayed
            options: []) // different options like destrucive and
        
        let alarmCategory = UNNotificationCategory(
            identifier: "alarm.category",
            actions: [snoozeAction], // snooze action
            intentIdentifiers: [], //siri stuff
            options: []) // custom dimiss functions
        
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SceneTableViewCell", for: indexPath) as! SceneTableViewCell
        
        let scene = scenes[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = scene.sceneName
        cell.statusSwitch.setOn(scene.onOff, animated: false)
        cell.statusSwitch.tag = indexPath.row
        
        return cell
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scenes.remove(at: indexPath.row)
             saveScenes()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        self.tableView.reloadData()
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for:segue, sender: sender)
        switch(segue.identifier ?? ""){
        case "AddScene":
            os_log("Adding a new scene.", log:OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let sceneDetailViewController = segue.destination as? SceneEditViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedSceneCell = sender as? SceneTableViewCell else {
                fatalError("The selected cell is not being displayed by the table")
            }
            guard let indexPath = tableView.indexPath(for: selectedSceneCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedScene = scenes[indexPath.row]
            sceneDetailViewController.scene = selectedScene
        default:
            fatalError("Unexpected Deque Identifier; \(segue.identifier)")
        }
        
        
        
    }
    private func saveScenes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(scenes, toFile: Scene.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Scenes successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save scenes.", log: OSLog.default, type: .error)
        }
    }
    
    private func loadScenes() -> [Scene]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Scene.ArchiveURL.path) as? [Scene]
        
    }
    

}
