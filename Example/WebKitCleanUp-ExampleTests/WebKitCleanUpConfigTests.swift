//
//  WebKitCleanUpConfigTests.swift
//  WebKitCleanUp-ExampleTests
//
//  Created by Hoang Nguyen on 8/8/23.
//

import XCTest
import WebKitCleanUp

final class WebKitCleanUpConfigTests: XCTestCase {
    
    func testParseConfig() {
        enum TestCase {
            case enabled
            case disaled
            
            var value: (Bool, Int) {
                switch self {
                case TestCase.enabled: return (true, 30)
                case TestCase.disaled: return (false, 1)
                }
            }
        }
        
        [TestCase.enabled, TestCase.disaled].forEach {  testCase in
            // when
            let config = WebKitCleanUpConfig(cleanUpEnabled: testCase.value.0, cleanUpDuration: testCase.value.1)
            
            // then
            switch testCase {
            case .enabled:
                XCTAssertTrue(config.cleanUpEnabled)
                XCTAssertEqual(config.cleanUpDuration, 30)
            case .disaled:
                XCTAssertFalse(config.cleanUpEnabled)
                XCTAssertEqual(config.cleanUpDuration, 1)
            }
        }
    }
}

