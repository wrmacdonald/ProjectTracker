//
//  Project.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
}

extension Calendar {
    func numberOfWorkDaysBetween(from: Date, to: Date, availableDays: [Int]) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let days = dateComponents([.day], from: fromDate, to: toDate).day!
        var workDayCount = 0
        
        // ensure from date is before to date
        guard from < to else {
            return 0
        }
        
        for day in 0..<days {
            let date = Calendar.current.date(byAdding: .day, value: day, to: fromDate)!
            let dateNum = Int(date.formatted(Date.FormatStyle().weekday(.oneDigit))) ?? -1
            if availableDays.contains(dateNum) {
                workDayCount += 1
            }
        }
        return workDayCount
    }
}

@Observable
class Project {
    var name = ""
    var startDate = Date()
    var endDate = Date()
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var availableWorkDays = [2, 3, 4, 5, 6]
    
    var calendar = Calendar(identifier: .gregorian)
    var daysTillCompletion: Int {
        return calendar.numberOfDaysBetween(startDate, and: endDate)
    }
    var workDaysUntilEnd: Int {
        return calendar.numberOfWorkDaysBetween(from: startDate, to: endDate, availableDays: availableWorkDays)
    }
    var workDaysRemainingUntilEnd: Int {
        return calendar.numberOfWorkDaysBetween(from: Date.now, to: endDate, availableDays: availableWorkDays)
    }
}
