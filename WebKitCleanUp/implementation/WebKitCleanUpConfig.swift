//
//  WebKitCleanUpConfig.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation

// MARK: WebKitCleanUpConfig
public struct WebKitCleanUpConfig {
    public let cleanUpEnabled: Bool
    public let cleanUpDuration: Int
    
    public init(cleanUpEnabled: Bool, cleanUpDuration: Int) {
        self.cleanUpEnabled = cleanUpEnabled
        self.cleanUpDuration = cleanUpDuration
    }
}
