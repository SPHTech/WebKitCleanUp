//
//  WebKitDiskDataStore.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKit

// MARK: WebKitDiskDataStore
public protocol WebKitDiskDataStore {
  /** @abstract Removes all website data of the given types that has been modified since the given date.
   @param dataTypes The website data types that should be removed.
   @param date A date. All website data modified after this date will be removed.
   @param completionHandler A block to invoke when the website data has been removed.
   */
  func removeData(ofTypes dataTypes: Set<String>, modifiedSince date: Date, completionHandler: @escaping () -> Void)
}

// MARK: WKWebsiteDataStore
extension WKWebsiteDataStore: WebKitDiskDataStore {}
