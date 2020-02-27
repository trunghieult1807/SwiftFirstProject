//
//  ExtensionDate.swift
//  DemoAppBeenLoveMemoryLite
//
//  Created by dohien on 06/09/2018.
//  Copyright © 2018 dohien. All rights reserved.
//

import UIKit
extension Date {
    func  interval(start: String, end: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: Date()) else { return 0 }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: end) else { return 0 }
        return end - start
    }
//    func years(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
//    }
//    func months(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
//    }
//    func weeks(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
//    }
//    func days(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
//    }
//    func hours(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
//    }
//    func minutes(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
//    }
//    func seconds(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
//    }
//    func nanoseconds(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
//    }
//    func offset(from date: Date) -> String {
//        var result: String = ""
//        if years(from: date) > 0 {
//            return "\(years(from: date))y"
//        }
//        if months(from: date) > 0 {
//          return "\(months(from: date))M"
//        }
//        if weeks(from: date) > 0{
//            return "\(weeks(from: date))W"
//        }
//        if days(from: date) > 0 {
//            result = result + " " + "\(days(from: date)) D"
//        }
//        if hours(from: date) > 0 {
//            result = result + " " + "\(hours(from: date)) H"
//        }
//        if minutes(from: date) > 0 {
//            result = result + " " + "\(minutes(from: date)) M"
//        }
//        if seconds(from: date) > 0 {
//            result = result + " " + "\(seconds(from: date))"
//        }
//        if seconds(from: date) > 0{
//            return "\(seconds(from: date))"
//        }
//        return ""
//    }
}

