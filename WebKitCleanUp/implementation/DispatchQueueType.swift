//
//  DispatchQueueType.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Dispatch

public protocol DispatchQueueType {
  func asyncAfter(deadline: DispatchTime, work: @escaping () -> Void)
  func async(work: @escaping () -> Void)
  func asyncAfter(deadline: DispatchTime, executeItem workItem: DispatchWorkItem)
}

extension DispatchQueue: DispatchQueueType {
  public func asyncAfter(deadline: DispatchTime, work: @escaping () -> Void) {
    self.asyncAfter(deadline: deadline, execute: work)
  }

  public func async(work: @escaping () -> Void) {
    self.async(execute: work)
  }

  public func asyncAfter(deadline: DispatchTime, executeItem workItem: DispatchWorkItem) {
    self.asyncAfter(deadline: deadline, execute: workItem)
  }
}
