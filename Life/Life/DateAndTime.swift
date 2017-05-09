//
//  DateAndTime.swift
//  Life
//
//  Created by Tyler Wilson on 4/12/17.
//  Copyright © 2017 Tyler Wilson. All rights reserved.
//

import Foundation

class DateAndTime{
    
    private let date = Date()
    private let now = Calendar.current
    
    private let months = [
        1: "January",
        2: "Feburary",
        3: "March",
        4: "April",
        5: "May",
        6: "June",
        7: "July",
        8: "August",
        9: "September",
        10: "October",
        11: "November",
        12: "December"
    ]
    
    private let days = [
        2: "Monday",
        3: "Tuesday",
        4: "Wednesday",
        5: "Thursday",
        6: "Friday",
        7: "Saturday",
        1: "Sunday"
    ]
    
    func getDate() -> String {
        let month = now.component(.month, from: date)
        let dayOfMonth = now.component(.day, from: date)
        let todaysDate = months[month]! + " " + String(dayOfMonth)
        return todaysDate
    }
    
    func getDay() -> String {
        let day = now.component(.weekday, from: date)
        return days[day]!
    }
    
    func getHour() -> Int16 {
        let hour = now.component(.hour, from: date)
        return Int16(hour)
    }
    
    
}
