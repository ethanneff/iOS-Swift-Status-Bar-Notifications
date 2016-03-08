# iOS-Swift-Status-Bar-Notifications

**purpose** to have a notification alert within the status bar area.

**vision** simular to the Dropbox Mailbox app

![image](http://i.imgur.com/Hlsm8Xj.jpg)

**methodology** 
- coded in Swift
- all controllers must import CustomViewController (Views and TableViews)
- access the statusbar notification at anytime via 
```swift
StatusBarNotification.show(text: String)
```
```swift
StatusBarNotification.hide(text: String?)
```

**status** although the solution works for all Controllers, it does not handle status bar scroll properly on UITableViewControllers.

![image](http://i.imgur.com/zS0qpyG.gif)
