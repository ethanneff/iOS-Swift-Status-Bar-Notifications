//
//  FirstViewController.swift
//  ToggleStatusBar
//
//  Created by Ethan Neff on 1/6/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import UIKit

class FirstViewController: CustomViewController {

  // MARK: properties
  @IBOutlet weak var button: UIButton!

  @IBAction func toggleStatusBar(sender: AnyObject) {
    // hide and show status bar
    StatusBarNotification.show(text: "Loading...")
    Utils.delay(1) { () -> () in
      StatusBarNotification.show(text: "Still loading...")
      Utils.delay(1) { () -> () in
        StatusBarNotification.show(text: "Lots of loading...")
        Utils.delay(1) { () -> () in
          StatusBarNotification.show(text: "Even more loading...")
          Utils.delay(1) { () -> () in
            StatusBarNotification.show(text: "Almost done...")
            Utils.delay(1) { () -> () in
              StatusBarNotification.hide(text: "Complete!")
            }
          }
        }
      }
    }
  }
}