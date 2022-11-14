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
        
        if weekDay == "Sun" {
            return date.next(.sunday)
        } else if weekDay == "Mon" {
            return date.next(.monday)
        }else if weekDay == "Tue" {
            return date.next(.tuesday)
        }else if weekDay == "Wed" {
            return date.next(.wednesday)
        }else if weekDay == "Thu" {
            return date.next(.tuesday)
        }else if weekDay == "Fri" {
            return date.next(.friday)
        }else {
            return date.next(.saturday)
        }
    }
    
}


// MAKR: // Date extension.
extension Date {
    
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
        nextDateComponent.weekday = searchWeekdayIndex
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case next
        case previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .next:
                return .forward
            case .previous:
                return .backward
            }
        }
    }
}
