//
//  WebKitCleanUpStatusMemoryTests.swift
//  WebKitCleanUp-ExampleTests
//
//  Created by Hoang Nguyen on 8/8/23.
//

import XCTest
import WebKitCleanUp

final class WebKitCleanUpStatusMemoryTests: XCTestCase {

  func testStoreDate() {
    // given
    let defaultsSuite = UserDefaultsSuite.custom(domain: "WebKitCleanUpStatusMemoryTests")
    let sut = DefaultWebKitCleanUpStatusMemory(defaultsSuite: defaultsSuite)
    let currentDate = Date()
    
    // when
    sut.storeLastSuccessDate(date: currentDate)
    
    // then
    XCTAssertEqual(sut.lastSuccessDate, currentDate)
  }
 
}
