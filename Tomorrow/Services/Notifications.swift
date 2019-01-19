//
//  Notifications.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/18/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation
import UserNotifications

class Notify {
    let center = UNUserNotificationCenter.current()
    
    // Make it impossible to initiate a new class
    private init() {}
    
    // Create a singleton
    static let shared = Notify()
    
    func createNotification(hour: Float) {
        // Create a notification
        let content = UNMutableNotificationContent()
        content.title = "Its that time!"
        content.body = "Enter tomorrow's todos before you forget."
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notifications temp"
        
        // Create a trigger time
        var dateComponents = DateComponents()
        dateComponents.hour = Int(hour)
        
        // Create a trigger
        let trigger  = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create a request
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        // Activate it
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
