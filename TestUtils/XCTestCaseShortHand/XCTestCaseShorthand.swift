//
//  XCTestCaseShorthand.swift
//  TestUtils
//
//  Created by Hoang Nguyen on 18/9/23.
//

import Foundation
import XCTest

public protocol XCTestCaseShorthand: XCTestCase {
    /// Wrapper for XCTContext.runActivity(). Will append "GIVEN" as prefix for the description.
    /// - Parameters:
    ///   - description: Describe the operation happen in the block
    ///   - block: Operation
    /// - Returns: Result of the operation
    func given<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result
    func given<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result
    
    /// Wrapper for XCTContext.runActivity(). Will append "AND" as prefix for the description.
    /// - Parameters:
    ///   - description: Describe the operation happen in the block
    ///   - block: Operation
    /// - Returns: Result of the operation
    func and<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result
    func and<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result
    
    /// Wrapper for XCTContext.runActivity(). Will append "WHEN" as prefix for the description.
    /// - Parameters:
    ///   - description: Describe the operation happen in the block
    ///   - block: Operation
    /// - Returns: Result of the operation
    func when<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result
    func when<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result
    
    /// Wrapper for XCTContext.runActivity(). Will append "THEN" as prefix for the description.
    /// - Parameters:
    ///   - description: Describe the operation happen in the block
    ///   - block: Operation
    /// - Returns: Result of the operation
    func then<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result
    func then<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result
}

public extension XCTestCaseShorthand {
    func given<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "GIVEN \(description)") { _ in
            try block()
        }
    }
    
    func given<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "GIVEN \(description)", block: block)
    }
    
    func and<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "AND \(description)") { _ in
            try block()
        }
    }
    
    func and<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "AND \(description)", block: block)
    }
    
    func when<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "WHEN \(description)") { _ in
            try block()
        }
    }
    
    func when<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "WHEN \(description)", block: block)
    }
    
    func then<Result>(_ description: String, _ block: () throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "THEN \(description)") { _ in
            try block()
        }
    }
    
    func then<Result>(_ description: String, _ block: (XCTActivity) throws -> Result) rethrows -> Result {
        try XCTContext.runActivity(named: "THEN \(description)", block: block)
    }
}
