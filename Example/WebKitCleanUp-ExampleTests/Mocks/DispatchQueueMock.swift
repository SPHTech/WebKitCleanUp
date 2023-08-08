//
//  DispatchQueueMock.swift
//  WebKitCleanUp-ExampleTests
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKitCleanUp

public class DispatchQueueMock: DispatchQueueType {
  public init() {}
  
  public func asyncAfter(deadline: DispatchTime, work: @escaping () -> Void) {
    work()
  }

  public func async(work: @escaping () -> Void) {
    work()
  }

  public func asyncAfter(deadline: DispatchTime, executeItem workItem: DispatchWorkItem) {}
}
