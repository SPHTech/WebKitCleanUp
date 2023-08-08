//
//  WebKitCleanUpStatusMemoryMock.swift
//  WebKitCleanUp-ExampleTests
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKitCleanUp

public final class WebKitCleanUpStatusMemoryMock: WebKitCleanUpStatusMemory {
  public var lastSuccessDate: Date?
  
  public func storeLastSuccessDate(date: Date) {
    self.lastSuccessDate = date
  }
  
  public init(lastSuccessDate: Date? = nil) {
    self.lastSuccessDate = lastSuccessDate
  }
}
