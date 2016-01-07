//
//  StatusBarNotification.swift
//  ToggleStatusBar
//
//  Created by Ethan Neff on 1/6/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import UIKit

class CustomUIViewController: UIViewController {
  
}

class StatusBarNotificationView: UIView {
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect) {
  // Drawing code
  }
  */
  
}

//class GlobalViewController : UIViewController {
//  var hideStatusBar = UIApplication.sharedApplication().statusBarHidden
//}

//
extension CustomUIViewController {
  // MARK: properties (hack since you cannot create stored properties from an extension)
  private struct AssociatedKeys {
    static var statusBarHidden = false
  }
  
  var statusBarHidden : Bool {
    get {
      guard let number = objc_getAssociatedObject(self, &AssociatedKeys.statusBarHidden) as? NSNumber else {
        return true
      }
      return number.boolValue
    }
    
    set(value) {
      objc_setAssociatedObject(self,&AssociatedKeys.statusBarHidden,NSNumber(bool: value),objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  // MARK: methods
  override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
    return .Slide
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return statusBarHidden
  }
}