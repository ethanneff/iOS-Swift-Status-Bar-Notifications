//
//  StatusBarNotification.swift
//  ToggleStatusBar
//
//  Created by Ethan Neff on 1/6/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import UIKit

extension CustomViewController {
  override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
    super.preferredStatusBarUpdateAnimation()
    return .Slide
  }
  
  override func prefersStatusBarHidden() -> Bool {
    super.prefersStatusBarHidden()
    return StatusBarNotification.hidden
  }
  
  func loadStatusBarNotification() {
    _ = StatusBarNotification(controller: self)
  }
}

class StatusBarNotification {
  // properties
  private(set) static var hidden: Bool = false
  private static var text: String = ""
  private static let events = EventManager()
  private static var queue = [Event]()
  private let controller: UIViewController
  private let view: UIView
  private let label: UILabel
  private var viewHidden: Bool = false
  
  private enum Actions {
    case Show, Hide, Appear
  }
  
  private enum Color {
    case Success, Failure, Default
  }
  
  private struct Event {
    let action: Actions
    let text: String?
    let color: Color?
  }
  
  // class methods 
  static func show(text text: String) {
    self.text = text;
    // publish to all the instances
    events.pub(eventName: "statusBarShow")
  }
  
  static func hide(text text: String?=nil) {
    if let _ = text {
      self.text = text!;
    } else {
      self.text = "";
    }
    
    events.pub(eventName: "statusBarHide")
  }
  
  // instance methods
  init(controller: UIViewController) {
    // create view
    func createView() -> (view: UIView, label: UILabel) {
      let container = UIView(frame: CGRectMake(0, 0, controller.view.frame.width, 20))
      container.backgroundColor = controller.view.backgroundColor
      container.clipsToBounds = true
      
      let label = UILabel(frame: CGRectMake(0, 0, controller.view.frame.width, 20))
      label.textAlignment = .Center
      label.text = "bob"
      label.font = UIFont.boldSystemFontOfSize(13)
      label.center.y = 30
      label.alpha = 0
      container.addSubview(label)
      controller.view.addSubview(container)
      
      return (container, label)
    }
    
    // assign instance properties
    let container = createView()
    self.controller = controller
    self.view = container.view;
    self.label = container.label;
    
    // listen to class properties
    StatusBarNotification.events.sub(eventName: "statusBarShow", action: showText)
    StatusBarNotification.events.sub(eventName: "statusBarHide", action: hideText)
    
    // load previous config if notification is already running
    if StatusBarNotification.hidden == true {
      displayText()
    }
  }
  
  private func showText() {
    if StatusBarNotification.hidden != true {
      StatusBarNotification.hidden = true
    }
    
    if self.viewHidden == false {
      self.viewHidden = true
      animateText()
    } else {
      displayText()
    }
  }
  
  private func hideText() {
    var wait = 0.0
    if StatusBarNotification.text.characters.count > 0 {
      label.text = StatusBarNotification.text;
      wait = 0.5;
    }
    
    Utils.delay(wait) { () -> () in
      if StatusBarNotification.hidden == true {
        StatusBarNotification.hidden = false
        StatusBarNotification.text = "";
      }
      
      if self.viewHidden == true {
        self.viewHidden = false
        self.animateText()
      } else {
        self.displayText()
      }
    }
  }
  private func animateText() {
    UIView.animateWithDuration(0.3) { () -> Void in
      self.controller.setNeedsStatusBarAppearanceUpdate()
      self.displayText()
    }
  }
  
  private func displayText() {
    label.center.y = (StatusBarNotification.hidden) ? 10 : 30
    label.alpha = (StatusBarNotification.hidden) ? 1 : 0
    label.text = StatusBarNotification.text;
  }
}