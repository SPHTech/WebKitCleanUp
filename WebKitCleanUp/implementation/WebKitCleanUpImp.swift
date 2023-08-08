//
//  WebKitCleanUpImp.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKit
#if canImport(BackgroundTasks)
import BackgroundTasks
#endif

public struct WebKitCleanUpImp: WebKitCleanUp {
    public let webKitDiskDataStore: WebKitDiskDataStore
    public let webKitCleanUpStatusMemory: WebKitCleanUpStatusMemory
    private let dispatchQueue: DispatchQueueType
    private let webKitCleanUpConfig: WebKitCleanUpConfig
    
    private enum Constant {
        static let webKitSubDirectory = "/WebKit"
    }
    
    public init(webKitCleanUpConfig: WebKitCleanUpConfig,
                dispatchQueue: DispatchQueueType = DispatchQueue.main,
                webKitDiskDataStore: WebKitDiskDataStore = WKWebsiteDataStore.default(),
                webKitCleanUpStatusMemory: WebKitCleanUpStatusMemory = DefaultWebKitCleanUpStatusMemory()) {
        self.webKitCleanUpConfig = webKitCleanUpConfig
        self.dispatchQueue = dispatchQueue
        self.webKitDiskDataStore = webKitDiskDataStore
        self.webKitCleanUpStatusMemory = webKitCleanUpStatusMemory
    }
    
    public func webKitDidCleanUpCache(cacheTypes: [WebKitCacheType],
                                      performMode: WebKitPerformMode,
                                      completionHandler: @escaping () -> Void) {
        var dataTypes: [String] = []
        for type in cacheTypes {
            switch type {
            case .fetch:   dataTypes.append(WKWebsiteDataTypeFetchCache)
            case .disk:    dataTypes.append(WKWebsiteDataTypeDiskCache)
            case .memory:  dataTypes.append(WKWebsiteDataTypeMemoryCache)
            }
        }
        let cleanTypes = Set(dataTypes)
        
        /// `webKitDiskDataStore.removeData()` method should be called on the main thread, as it may interact with the web view's UI.
        ///  If you call this method on a background thread, it may cause a crash.
        dispatchQueue.async {
            webKitDiskDataStore.removeData(ofTypes: cleanTypes, modifiedSince: Date.distantPast) {
                
                webKitCleanUpStatusMemory.storeLastSuccessDate(date: Date())
                
                completionHandler()
            }
        }
    }
    
    /// This value to check feature flag & compare last success data
    public var isWebKitCleanUpEnabled: Bool {
        guard webKitCleanUpConfig.cleanUpEnabled else { return false }
        guard let lastSuccessDate = webKitCleanUpStatusMemory.lastSuccessDate else { return true }
        let numberOfDays = Date().days(before: lastSuccessDate)
        return numberOfDays >= webKitCleanUpConfig.cleanUpDuration
    }
}
