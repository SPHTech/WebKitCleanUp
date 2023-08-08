//
//  Date+Extensions.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation

extension Date {
  func days(before date: Date) -> Int {
    let ti = self.timeIntervalSince(date)
    return Int(ti / 86400)
  }
}
