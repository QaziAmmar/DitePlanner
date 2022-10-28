//
//  DateManager.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 29/03/2022.
//

import Foundation

extension Date {

    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }

}

class DateManager {
    
    static let standard = DateManager()
    
    
    func monthNameWithDate(strDate: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: strDate) ?? Date()

        let outformatter = DateFormatter()
        outformatter.dateFormat = "MMMM d yyyy"
        return outformatter.string(from: date)
    }
    
    func getCurrentString(from date: Date) -> String {
        let outformatter = DateFormatter()
        outformatter.dateFormat = "MM/dd/yyyy h:mm a"
        return outformatter.string(from: date)
    }
    
    func getCurrentDate(from strDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let date = formatter.date(from: strDate) ?? Date()
        return date
    }
    
    /// This function will extract the time form the current date string
    func getTimeFrom(strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy h:mm a"
        let date = formatter.date(from: strDate) ?? Date()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    func getCurrentDateAndTime(strDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy h:mm a"
        let date = formatter.date(from: strDate) ?? Date()
        return date
    }
    
    func getWeekNamewithDate(from date: Date) -> String {
        let outformatter = DateFormatter()
        outformatter.dateFormat = "E, MMM d"
        return outformatter.string(from: date)
    }
    
    func getDayOfTheYear() -> Int {
        let date = Date() // now
        let cal = Calendar.current
        let day = cal.ordinality(of: .day, in: .year, for: date)
        return ((day) ?? 0) % 226
    }
    
    // get the date components form the date
    func getCalanderComponent(date: Date) -> DateComponents {

        // *** create calendar object ***
        let calendar = Calendar.current

        // *** Get components using current Local & Timezone ***
//        print(calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))

        // *** Get All components from date ***
        let components = calendar.dateComponents([.hour, .year, .minute], from: date)
        print(components)
        return components
        
    }
    
    
}
