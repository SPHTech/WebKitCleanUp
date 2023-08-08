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
  
  public func async(work: @escaping () -> Void) {
    work()
  }
}
