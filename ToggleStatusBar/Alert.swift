//
//  Alert.swift
//  ToggleStatusBar
//
//  Created by Ethan Neff on 1/7/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import Foundation
import UIKit

class Alert {
  static func showWithDuration(controller controller: UIViewController, title: String, message: String?=nil, duration: Double, var style: UIAlertControllerStyle?=nil) {
    // TODO: make queue for alerts (cannot display multiple alerts at the same time)
    
    // optionals
    if let _ = style {} else {
      style = .Alert
    }
    
    // alert
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style!)
    
    // display
    controller.presentViewController(alertController, animated: true, completion: nil)
    
    // duration
    dispatch_after(
      dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(duration * Double(NSEC_PER_SEC))
      ),
      dispatch_get_main_queue(), {
        alertController.dismissViewControllerAnimated(true, completion: nil)
      }
    )
  }
  
  static func showWithButtons(controller controller: UIViewController, title: String, message: String?=nil, var style: UIAlertControllerStyle?=nil,
    button1Title: String, var button1Type: UIAlertActionStyle?=nil,
    button2Title: String?=nil, var button2Type: UIAlertActionStyle?=nil, completion: (button: String) -> Void) {
      // optionals
      if let _ = style {} else {
        style = .Alert
      }
      if let _ = button1Type {} else {
        button1Type = .Default
      }
      if let _ = button2Type {} else {
        button2Type = .Cancel
      }
      
      // alert
      let alertController = UIAlertController(title: title, message: message, preferredStyle: style!)
      
      // buttons
      alertController.addAction(UIAlertAction(title: button1Title, style: button1Type!, handler: { (UIAlertAction) -> Void in
        completion(button: button1Title)
      }))
      
      if let _ = button2Title {
        alertController.addAction(UIAlertAction(title: button2Title!, style: button2Type!, handler: { (UIAlertAction) -> Void in
          completion(button: button2Title!)
        }))
      }
      
      // display
      controller.presentViewController(alertController, animated: true, completion: nil)
  }
}