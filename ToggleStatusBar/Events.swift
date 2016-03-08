//
//  Events.swift
//  test
//
//  Created by Ethan Neff on 1/8/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import Foundation

class EventManager {
  // using NSMutableArray as Swift arrays can't change size inside dictionaries (yet, probably)
  var listeners = Dictionary<String, NSMutableArray>();
  
  // Create a new event listener, not expecting information from the trigger
  // + eventName: Matching trigger eventNames will cause this listener to fire
  // + action: The block of code you want executed when the event triggers
  func sub(eventName eventName:String, action:(()->())) {
    let newListener = EventListenerAction(callback: action);
    addListener(eventName: eventName, newEventListener: newListener);
  }
  
  // Create a new event listener, expecting information from the trigger
  // + eventName: Matching trigger eventNames will cause this listener to fire
  // + action: The block of code you want executed when the event triggers
  func sub(eventName eventName:String, action:((Any?)->())) {
    let newListener = EventListenerAction(callback: action);
    addListener(eventName: eventName, newEventListener: newListener);
  }
  
  internal func addListener(eventName eventName:String, newEventListener:EventListenerAction) {
    if let listenerArray = self.listeners[eventName] {
      // action array exists for this event, add new action to it
      listenerArray.addObject(newEventListener);
    }
    else {
      // no listeners created for this event yet, create a new array
      self.listeners[eventName] = [newEventListener] as NSMutableArray;
    }
  }
  
  // Removes all listeners by default, or specific listeners through paramters
  // + eventName: If an event name is passed, only listeners for that event will be removed
  func removeListeners(eventNameToRemoveOrNil:String?) {
    if let eventNameToRemove = eventNameToRemoveOrNil {
      // remove listeners for a specific event
      
      if let actionArray = self.listeners[eventNameToRemove] {
        // actions for this event exist
        actionArray.removeAllObjects();
      }
    }
    else {
      // no specific parameters - remove all listeners on this object
      self.listeners.removeAll(keepCapacity: false);
    }
  }
  
  // Triggers an event
  // + eventName: Matching listener eventNames will fire when this is called
  // + information: pass values to your listeners
  func pub(eventName eventName:String, information:Any? = nil) {
    if let actionObjects = self.listeners[eventName] {
      for actionObject in actionObjects {
        if let actionToPerform = actionObject as? EventListenerAction {
          if let methodToCall = actionToPerform.actionExpectsInfo {
            methodToCall(information);
          }
          else if let methodToCall = actionToPerform.action {
            methodToCall();
          }
        }
      }
    }
  }
}

// Class to hold actions to live in NSMutableArray
class EventListenerAction {
  let action:(() -> ())?;
  let actionExpectsInfo:((Any?) -> ())?;
  
  init(callback:(() -> ())) {
    self.action = callback;
    self.actionExpectsInfo = nil;
  }
  
  init(callback:((Any?) -> ())) {
    self.actionExpectsInfo = callback;
    self.action = nil;
  }
}