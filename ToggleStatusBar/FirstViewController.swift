//
//  FirstViewController.swift
//  ToggleStatusBar
//
//  Created by Ethan Neff on 1/6/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
  // MARK: properties
  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var statusBarLabel: UILabel!
  var statusBarHidden = UIApplication.sharedApplication().statusBarHidden;

  
  override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
    return .Slide
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return statusBarHidden
  }
  
  // MARK: controls
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // hide and show loading view
    let statusBarContainer = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 20))
    statusBarContainer.backgroundColor = self.view.backgroundColor
    statusBarContainer.clipsToBounds = true
    
    let statusBarLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, 20))
    statusBarLabel.textAlignment = .Center
    statusBarLabel.text = "Hidden notification bar...";
    statusBarLabel.font = UIFont.boldSystemFontOfSize(13)
    statusBarLabel.center.y += 20
    self.statusBarLabel = statusBarLabel
    
    statusBarContainer.addSubview(self.statusBarLabel)
    self.view.addSubview(statusBarContainer)
  }
  
  
  @IBAction func toggleStatusBar(sender: AnyObject) {
    // hide and show status bar
    statusBarHidden = !statusBarHidden
    UIView.animateWithDuration(0.3) { () -> Void in
      self.setNeedsStatusBarAppearanceUpdate()
      self.statusBarLabel.center.y += (self.statusBarHidden) ? -20 : 20;
    }
  }
  
  @IBAction func alertTheUser(button: UIButton) {
    statusBarHidden = true;
    button.enabled = false;
    statusBarLabel.text = "Loading..."
    UIView.animateWithDuration(0.3) { () -> Void in
      self.setNeedsStatusBarAppearanceUpdate()
      self.statusBarLabel.center.y += (self.statusBarHidden) ? -20 : 20;
    }
    
    self.delay(2.0) { () -> () in
      self.statusBarLabel.text = "Complete!"
      self.delay(0.5) { () -> () in
        self.statusBarHidden = false;
        button.enabled = true;
        UIView.animateWithDuration(0.3) { () -> Void in
          self.setNeedsStatusBarAppearanceUpdate()
          self.statusBarLabel.center.y += (self.statusBarHidden) ? -20 : 20;
        }
      }
    }
  }
  
  func delay(delay:Double, closure:()->()) {
    dispatch_after(
      dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
      ),
      dispatch_get_main_queue(), closure)
  }
}