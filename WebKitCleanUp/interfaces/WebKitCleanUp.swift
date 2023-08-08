//
//  ViewController.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKit

// MARK: WebKitCacheType
public enum WebKitCacheType {
    /// This constant represents cached web resources that were downloaded for offline use such as images, stylesheets, and scripts.
    case fetch
    
    /// This constant represents data that is stored in the disk cache of a website.
    case disk
    
    /// This constant represents data that is stored in the memory cache of a website.
    case memory
}

// MARK: WebKitPerformMode
public enum WebKitPerformMode: String {
    case background
    case foreground
}

// MARK: WebKitCleanUp
public protocol WebKitCleanUp {
    
    var isWebKitCleanUpEnabled: Bool { get }
    
    /// Clean data from WebKitDiskDataStore
    var webKitDiskDataStore: WebKitDiskDataStore { get }
    
    /// Store the clean up result for webkit. This storage will be spared from being cleaned up.
    var webKitCleanUpStatusMemory: WebKitCleanUpStatusMemory { get }
    
    func webKitDidCleanUpCache(cacheTypes: [WebKitCacheType],
                               performMode: WebKitPerformMode,
                               completionHandler: @escaping () -> Void)
}

#if TESTING
extension WebKitCacheType: Equatable {
    public static func ==(lhs: WebKitCacheType, rhs: WebKitCacheType) -> Bool {
        switch (lhs, rhs) {
        case (.fetch, .fetch),
            (.disk, .disk),
            (.memory, .memory):
            return true
        default:
            return false
        }
    }
}
#endif


