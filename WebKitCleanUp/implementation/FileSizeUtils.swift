//
//  FileSizeUtils.swift
//  WebKitCleanUp
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation

public protocol FileSizeUtils {
    /// - Returns: Array of file-size informations of all files under the directory recursively
    func allFileSizes(at directoryURL: URL) -> [FileSizeInfo]
}

public struct FileSizeInfo {
    /// path of the file
    public let path: String
    /// file size in bytes
    public let size: Int
    
    public init(path: String, size:Int) {
        self.path = path
        self.size = size
    }
}

public struct FileSizeUtilsImp: FileSizeUtils {
    private let fileSizeResourceKeys: Set<URLResourceKey> = [.isRegularFileKey, .fileSizeKey]
    
    private init() { }
    
    public static let shared = FileSizeUtilsImp()
    
    
    public func allFileSizes(at directoryURL: URL) -> [FileSizeInfo] {
        guard let enumerator = FileManager.default.enumerator(at: directoryURL,
                                                              includingPropertiesForKeys: Array(fileSizeResourceKeys)) else {
            return []
        }
        
        var allFileSizes = [FileSizeInfo]()
        
        for item in enumerator {
            guard let contentItemURL = item as? URL,
                  !isDirectory(url: contentItemURL),
                  let size = fileSize(at: contentItemURL)  else { continue }
            allFileSizes.append(FileSizeInfo(path: contentItemURL.path, size: size))
        }
        return allFileSizes
    }
    
    private func isDirectory(url: URL) -> Bool {
        guard let resourceValues = try? url.resourceValues(forKeys: [.isDirectoryKey]) else {
            return false
        }
        return resourceValues.isDirectory ?? false
    }
    
    private func fileSize(at fileURL: URL) -> Int? {
        guard let resourceValues = try? fileURL.resourceValues(forKeys: fileSizeResourceKeys) else {
            return nil
        }
        guard resourceValues.isRegularFile ?? false else {
            return nil
        }
        return resourceValues.fileSize ?? nil
    }
}
