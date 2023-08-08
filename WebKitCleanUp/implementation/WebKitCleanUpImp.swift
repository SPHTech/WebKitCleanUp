//
//  WebKitCleanUpImp.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKit

public struct WebKitCleanUpImp: WebKitCleanUp {
    public let webKitDiskDataStore: WebKitDiskDataStore
    public let webKitCleanUpStatusMemory: WebKitCleanUpStatusMemory
    private let dispatchQueue: DispatchQueueType
    private let webKitCleanUpConfig: WebKitCleanUpConfig
    private let fileSizeUtils: FileSizeUtils
    
    private enum Constant {
        static let webKitSubDirectory = "/WebKit"
    }
    
    public init(webKitCleanUpConfig: WebKitCleanUpConfig,
                dispatchQueue: DispatchQueueType = DispatchQueue.main,
                webKitDiskDataStore: WebKitDiskDataStore = WKWebsiteDataStore.default(),
                webKitCleanUpStatusMemory: WebKitCleanUpStatusMemory = DefaultWebKitCleanUpStatusMemory(),
                fileSizeUtils: FileSizeUtils = FileSizeUtilsImp.shared) {
        self.webKitCleanUpConfig = webKitCleanUpConfig
        self.dispatchQueue = dispatchQueue
        self.webKitDiskDataStore = webKitDiskDataStore
        self.webKitCleanUpStatusMemory = webKitCleanUpStatusMemory
        self.fileSizeUtils = fileSizeUtils
    }
    
    public func webKitDidCleanUpCache(cacheTypes: [WebKitCacheType],
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
    
    /// Calculated webkit size
     public func getWebKitSize() -> Int {
       guard let cacheDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return 0 }
       let webKitPath = cacheDirectory + Constant.webKitSubDirectory
       let files = self.fileSizeUtils.allFileSizes(at: URL(fileURLWithPath: webKitPath))
       return files.reduce(0) { (result, fileSizeInfo) -> Int in return result + fileSizeInfo.size }
     }
}
