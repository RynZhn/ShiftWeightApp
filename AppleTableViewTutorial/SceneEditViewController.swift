//
//  ViewController.swift
//  Notification
//
//  Created by QL+ on 1/20/18.
//  Copyright © 2018 QL+ . All rights reserved.
//

import UIKit
import os.log
import UserNotifications
import Foundation


class SceneEditViewController: UIViewController {
    var scene: Scene?
    
    //MARK: Properties
    @IBOutlet weak var SceneTextField: UITextField!
    @IBOutlet weak var SceneName: UILabel!
    @IBOutlet weak var NotificationTextField: UITextField!
    @IBOutlet weak var NotificationName: UILabel!
    @IBOutlet weak var DescriptionTextField: UITextField!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Reminder: UILabel!
    @IBOutlet weak var Timer: UIDatePicker!
    @IBOutlet weak var SilentReminder: UILabel!
    @IBOutlet weak var SilentSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    //this method lets you configure a view controller before its presented
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, canceling", log: OSLog.default, type: .debug)
            return
        }
        let name = SceneTextField.text!
        
        let notif = NotificationTextField.text!
        let descrip = DescriptionTextField.text!
        let SceneSwitch = SilentSwitch.isOn
        Timer.datePickerMode = UIDatePickerMode.countDownTimer
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = Int(Timer.countDownDuration);
        scene = Scene(sceneName: name, notificationName: notif, notificationDescription: descrip, timer: time,onOff: false, silentSwitch: SceneSwitch)
        NotificationFunctions().clearNotCenter()
        
    }
/*
    @IBAction func Done(_ sender: Any) {
        
    name = SceneTextField.text!

    notif = NotificationTextField.text!
    descrip = DescriptionTextField.text!
    SceneSwitch = SilentSwitch.isOn
    Timer.datePickerMode = UIDatePickerMode.countDownTimer
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var TimeValue = dateFormatter.string(from: Timer.date)
        let date = dateFormatter.date(from: TimeValue)
        let calendar = Calendar.current
        var comp = calendar.dateComponents([.hour, .minute], from: date!)
        var hour = comp.hour
        var minute = comp.minute
        SceneTextField.text = " "
        NotificationTextField.text = " "
        DescriptionTextField.text = " "   
        SilentSwitch.setOn(false, animated: true);
        performSegue(withIdentifier: "home", sender: self)
        var seconds: Int = (hour! * 60) * 60 + (minute! * 60)
        var Scene1 = SceneData.init(sceneName: name, notificationName: notif, description: descrip, timer: seconds, silentSwitch: SceneSwitch)
        Scenes.append(Scene1)
    }
 */
/*
    @IBAction func printData(_ sender: Any) {
        
        if(Scenes.count > 0){
        print(Scenes[0].notificationName)
        print(Scenes[0].sceneName)
        print(Scenes[0].silentSwitch)
        print(Scenes[0].timer)
        }
    }
*/
    /*
    @IBAction func Cancel(_ sender: Any) {
        SceneTextField.text = " "
        NotificationTextField.text = " "
        DescriptionTextField.text = " "
        SilentSwitch.setOn(false, animated: true);
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let scene = scene {
            navigationItem.title = scene.sceneName
            SceneTextField.text = scene.sceneName
            NotificationTextField.text = scene.notificationName
            DescriptionTextField.text = scene.notificationDescription
            Timer.countDownDuration = TimeInterval(scene.timer)
            SilentSwitch.setOn(scene.silentSwitch, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

