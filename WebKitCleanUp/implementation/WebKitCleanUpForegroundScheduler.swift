//
//  WebKitCleanUpForegroundScheduler.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
// MARK: WebKitCleanUpForegroundScheduler
public struct WebKitCleanUpForegroundScheduler {
  
  private enum Constants {
    static let dispatchQueueLabel = "com.sph.foreground.web_kit_clean_up_queue"
  }
  
  public let webKitCleanUp: WebKitCleanUp
  public let dispatchQueue: DispatchQueueType
  
  public init(webKitCleanUp: WebKitCleanUp,
              dispatchQueue: DispatchQueueType) {
    self.webKitCleanUp = webKitCleanUp
    self.dispatchQueue = dispatchQueue
  }
  
  public init(webKitCleanUp: WebKitCleanUp) {
    self.init(webKitCleanUp: webKitCleanUp,
              dispatchQueue: DispatchQueue(label: Constants.dispatchQueueLabel, attributes: .concurrent))
  }
  
  public func executeWebKitCleanUp(cacheTypes: [WebKitCacheType]) {
    dispatchQueue.async {
      webKitCleanUp.webKitDidCleanUpCache(cacheTypes: cacheTypes,
                                          performMode: .foreground,
                                          completionHandler: {
          // TODO: Trigger Analystic event when clean up finish
      })
    }
  }
}

