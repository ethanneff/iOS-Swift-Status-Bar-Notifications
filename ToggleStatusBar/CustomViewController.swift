//
//  CustomUIViewController.swift
//  ToggleStatusBar
//
//  Created by Ethan Neff on 1/8/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import Foundation
import UIKit

// combine UITableViewController and UIViewController into one
class CustomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView?.delegate = self
    self.tableView?.dataSource = self
    loadStatusBarNotification()
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    return cell
  }
}