//
//  WebKitCleanUpImpTests.swift
//  WebKitCleanUp-ExampleTests
//
//  Created by Hoang Nguyen on 8/8/23.
//

import Foundation
import WebKitCleanUp
import XCTest

final class WebKitCleanUpImpTests: XCTestCase {
    private var webKitCleanUpStatusMemoryMock: WebKitCleanUpStatusMemoryMock!
    private var webKitDiskDataStoreMock: WebKitDiskDataStoreMock!
    private var dispatchQueueMock: DispatchQueueMock!
    
    override func setUp() {
        super.setUp()
        webKitCleanUpStatusMemoryMock = WebKitCleanUpStatusMemoryMock()
        webKitDiskDataStoreMock = WebKitDiskDataStoreMock(removeDataSuccess: true)
        dispatchQueueMock = DispatchQueueMock()
    }
    
    override func tearDown() {
        webKitCleanUpStatusMemoryMock = nil
        webKitDiskDataStoreMock = nil
        dispatchQueueMock = nil
        super.tearDown()
    }
    
    func testIsWebKitCleanUpEnabled() {
        [true, false].forEach { value in
            // when
            let sut = WebKitCleanUpImp(webKitCleanUpConfig: WebKitCleanUpConfig(cleanUpEnabled: value, cleanUpDuration: 1))
            
            //then
            XCTAssertEqual(sut.isWebKitCleanUpEnabled, value)
        }
    }
    
    func testIsWebKitCleanUpEnabledForLastSuccessDate() {
        // given
        [-3, -2, -1, 0, 1, 2, 3].forEach { day in
            webKitCleanUpStatusMemoryMock.lastSuccessDate = getDay(day)
            
            // when
            let sut = WebKitCleanUpImp(webKitCleanUpConfig: WebKitCleanUpConfig(cleanUpEnabled: true, cleanUpDuration: 1),
                                       dispatchQueue: dispatchQueueMock,
                                       webKitDiskDataStore: webKitDiskDataStoreMock,
                                       webKitCleanUpStatusMemory: webKitCleanUpStatusMemoryMock)
            //then
            XCTAssertEqual(sut.isWebKitCleanUpEnabled, day < 0)
        }
    }
    
    func testWebKitDidCleanUpCache() {
        // given
        webKitCleanUpStatusMemoryMock.lastSuccessDate = nil
        let sut = WebKitCleanUpImp(webKitCleanUpConfig: WebKitCleanUpConfig(cleanUpEnabled: true, cleanUpDuration: 1),
                                   dispatchQueue: dispatchQueueMock,
                                   webKitDiskDataStore: webKitDiskDataStoreMock,
                                   webKitCleanUpStatusMemory: webKitCleanUpStatusMemoryMock)
        // when
        sut.webKitDidCleanUpCache(cacheTypes: [.disk]) {
            
            //then
            XCTAssertNotNil(self.webKitCleanUpStatusMemoryMock.lastSuccessDate)
        }
        
    }
    
    
    private func getDay(_ number: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: number, to: Date()) ?? Date()
    }
}
