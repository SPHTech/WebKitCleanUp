//
//  WebKitCleanUpStatusMemory.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation

// MARK: WebKitCleanUpStatusMemory
public protocol WebKitCleanUpStatusMemory {
  var lastSuccessDate: Date? { get }
  func storeLastSuccessDate(date: Date)
}

// MARK: DefaultWebKitCleanUpStatusMemory
public struct DefaultWebKitCleanUpStatusMemory: WebKitCleanUpStatusMemory {
  
  private enum Constants {
    static let storageKey: String = "WebKitCleanUpStatus"
  }
  
  private let defaultsSuite: UserDefaultsSuite
  
  public init(defaultsSuite: UserDefaultsSuite = .standard) {
    self.defaultsSuite = defaultsSuite
  }
  
  public func storeLastSuccessDate(date: Date) {
    guard let defaults = defaultsSuite.userDefaults() else { return }
    if let encoded = try? JSONEncoder().encode(date) {
      defaults.set(encoded, forKey: Constants.storageKey)
    }
  }
  
  public var lastSuccessDate: Date? {
    guard let defaults = defaultsSuite.userDefaults() else { return nil }
    guard let data = defaults.value(forKey: Constants.storageKey) as? Data else { return nil }
    guard let result = try? JSONDecoder().decode(Date.self, from: data) else { return nil }
    return result
  }
}
