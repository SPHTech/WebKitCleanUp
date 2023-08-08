//
//  WebKitDiskDataStoreMock.swift
//  WebKitCleanUp-ExampleTests
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKitCleanUp

// MARK: WebKitDiskDataStoreMock
public final class WebKitDiskDataStoreMock: WebKitDiskDataStore {
  public let removeDataSuccess: Bool

  public init(removeDataSuccess: Bool = false) {
    self.removeDataSuccess = removeDataSuccess
  }
  
  public func removeData(ofTypes dataTypes: Set<String>, modifiedSince date: Date, completionHandler: @escaping () -> Void) {
    guard removeDataSuccess else { return }
    completionHandler()
  }
}
