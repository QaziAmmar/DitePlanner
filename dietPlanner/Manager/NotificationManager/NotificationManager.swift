//
//  NotificationManager.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 11/08/2022.
//

import Foundation
import UserNotifications
import SwiftUI



class NotificationManger: NSObject{
    
    static let standard = NotificationManger()

//    func requestPremission()  {
//        
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                print("All set!")
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//        
//    }

//    func createNotifocation(task: TDLModel)  {
//        
//        let content = UNMutableNotificationContent()
//        
//        content.title = "TODO List Reminder"
//        content.subtitle = task.task_name
//        content.sound = .default
//        
//        let TDLNotificationDate = DateManager.standard.getCurrentDateAndTime(strDate: task.date)
//        let TDLDatecompoment = DateManager.standard.getCalanderComponent(date: TDLNotificationDate)
//        print("Notification create for the date\(task.date)")
//
//       let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
//      // let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
//
//        let category = UNNotificationCategory(identifier: "action", actions: [open], intentIdentifiers: [])
//
//        UNUserNotificationCenter.current().setNotificationCategories([category])
//
//        content.categoryIdentifier = "action"
//
//        // show this notification at give time from now
//        let trigger = UNCalendarNotificationTrigger(dateMatching: TDLDatecompoment, repeats: true)
//        
//        // chose task identifier
//        let request = UNNotificationRequest(identifier: task.id ?? "0", content: content, trigger: trigger)
//        //add our notifiacion request
//        UNUserNotificationCenter.current().add(request)
//        
//    }
    
    func removeNotification(taskID: String) {
    
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [taskID])
    }
    
}

