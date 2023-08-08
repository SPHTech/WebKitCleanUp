//
//  DispatchQueueType.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Dispatch

public protocol DispatchQueueType {
  func async(work: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueType {
  public func async(work: @escaping () -> Void) {
    self.async(execute: work)
  }
}
