//
//  DateManager.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 29/03/2022.
//

import Foundation



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
        outformatter.dateFormat = "MM-dd-yyyy"
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
    
    func getWeekDayNameWith(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"
        return dateFormatter.string(from: date)
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
    
    /// This function will get the date base on the name of week day.
    func getDateFromWeekDay(weekDay: String, date: Date) -> Date {
        
        var returnDate: Date!
        
        //        check if return date and current date is equal then you need to return the current date
        let currentDate = Date()
        if currentDate.hasSame(.day, as: date) {
            return currentDate
        }

        if weekDay == "Sun" {
            returnDate = date.next(.sunday)
        } else if weekDay == "Mon" {
            returnDate = date.next(.monday)
        }else if weekDay == "Tue" {
            returnDate = date.next(.tuesday)
        }else if weekDay == "Wed" {
            returnDate = date.next(.wednesday)
        }else if weekDay == "Thu" {
            returnDate = date.next(.thursday)
        }else if weekDay == "Fri" {
            returnDate = date.next(.friday)
        }else {
            returnDate = date.next(.saturday)
        }
      
        return returnDate
    }
    
}


