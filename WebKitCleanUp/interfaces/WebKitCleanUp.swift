//
//  WebKitCleanUp.swift
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

// MARK: WebKitCleanUp
public protocol WebKitCleanUp {
    
    var isWebKitCleanUpEnabled: Bool { get }
    
    /// Clean data from WebKitDiskDataStore
    var webKitDiskDataStore: WebKitDiskDataStore { get }
    
    /// Store the clean up result for webkit. This storage will be spared from being cleaned up.
    var webKitCleanUpStatusMemory: WebKitCleanUpStatusMemory { get }
    
    /// Executed clean up
    func webKitDidCleanUpCache(cacheTypes: [WebKitCacheType], completionHandler: @escaping () -> Void)
    
    /// Get webkit size before and atfter clean up to verify
    func getWebKitSize() -> Int
}


