//
//  Project.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import Foundation
import SwiftData

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
            let dayArrayIndex = dateNum - 1    // convert into array index
            if availableDays.contains(dayArrayIndex) {
                workDayCount += 1
            }
        }
        return workDayCount
    }
}

@Model
class Project {
    var name: String
    var startDate: Date
    var endDate: Date
    var availableWorkDays: [Int]     // by index of days array (0=Sun, 1=Mon...) (default: weekdays)
    
//    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var numDaysStartUntilEnd: Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.numberOfDaysBetween(startDate, and: endDate)
    }
    var numWorkDaysStartUntilEnd: Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.numberOfWorkDaysBetween(from: startDate, to: endDate, availableDays: availableWorkDays)
    }
    var numWorkDaysNowUntilEnd: Int {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.numberOfWorkDaysBetween(from: Date.now, to: endDate, availableDays: availableWorkDays)
    }
    
    init(
        name: String,
        startDate: Date,
        endDate: Date,
        availableWorkDays: [Int]
    ) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.availableWorkDays = availableWorkDays
    }
}
