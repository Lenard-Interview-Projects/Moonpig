//
//  Date+Extensions.swift
//  moonpig-interview
//
//  Created by Lenard Pop on 23/08/2023.
//

import Foundation

extension Date {

    init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "UTC") ?? TimeZone.current

        let date = calendar.date(from: DateComponents(
                                    calendar: calendar,
                                    year: year,
                                    month: month,
                                    day: day,
                                    hour: hour,
                                    minute: minute,
                                    second: second))!
        self.init(timeInterval: 0, since: date)
    }

    init(daysSinceNow: TimeInterval) {
        let hour: Double = 60 * 60
        let day: Double = hour * 24
        self.init(timeIntervalSinceNow: day * daysSinceNow)
    }

    ///  It will be re-formatting the current date into a more friendly one
    ///  which will help understand it better
    ///  ```swift
    ///  `d'th' MMM yyyy`
    ///  8th Feb 2023
    ///  ```
    func toFriendlyDateLong() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d'\(self.daySuffix())' MMM yyyy"
        formatter.timeZone = TimeZone(identifier: "Europe/London")

        return formatter.string(from: self)
    }

    ///  It will be re-formatting the current date into a more friendly one
    ///  which will help understand it better
    ///  ```swift
    ///  `d'th' MMM yy`
    ///  8th Feb 23
    ///  ```
    func toFriendlyDateShort() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d'\(self.daySuffix())' MMM yy"
        formatter.timeZone = TimeZone(identifier: "Europe/London")

        return formatter.string(from: self)
    }

    private func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
