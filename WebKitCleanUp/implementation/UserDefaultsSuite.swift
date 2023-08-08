//
//  UserDefaultsSuite.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation

/// An entity to categorize UserDefaults as standard or custom for clean up purposes.
public enum UserDefaultsSuite {
  case standard
  case custom(domain: String)
  
  /// Create UserDefaults instance from given case.
  public func userDefaults() -> UserDefaults? {
    switch self {
    case .standard:
      return UserDefaults.standard
    case .custom(let domain):
      return UserDefaults(suiteName: domain)
    }
  }
}
