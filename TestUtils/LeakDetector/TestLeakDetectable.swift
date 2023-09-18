//
//  TestLeakDetectable.swift
//  TestUtils
//
//  Created by Hoang Nguyen on 18/9/23.
//


import Foundation
import XCTest

/// Detect memory leaks of unit test objects,
/// to support leak detection for a test case class, just conform to this protocol.
/// Example of usage:
/// ```
///   final class ExampleUnitTests: XCTestCase, TestLeakDetectable {
///     // Step1: specify the targets for leak check.
///     func targetsForLeakTest() -> [AnyObject] { [target1, target2...] }
///
///     // Step2: implement logic to release targets before leak test.
///     func releaseTargetsBeforeLeakTest() {
///       target1 = nil
///       target2 = nil
///     }
///
///     // Step3: override `tearDown()` function, to call the `performLeakTest()`.
///     override func tearDown() {
///       performLeakTest()
///       super.tearDown()
///     }
///
///     func testSomething() {
///       // Start your test
///     }
/// ```
/// Or if you only care about just single sut, the simpler solution is to use `BaseLeakFreeSingleUnitTestCase`.
public protocol TestLeakDetectable {
  /// The objects to be checked for memory leaks.
  func targetsForLeakTest() -> [AnyObject]
  /// To release the references to the objects, before leak test.
  func releaseTargetsBeforeLeakTest()
}

extension TestLeakDetectable where Self: XCTestCase {
  /// perform leak test, do not overwrite it.
  public func performLeakTest() {
    guard !targetsForLeakTest().isEmpty else { return }

    // Given
    var targets = targetsForLeakTest()
    var deinitCalls = Array(repeating: false, count: targets.count)

    // When
    for (index, target) in targets.enumerated() {
      ObjectDeinitHooker.hook(forObject: target) {
        deinitCalls[index] = true
      }
    }

    // Release targets for leak test
    targets = []
    releaseTargetsBeforeLeakTest()

    // Then
    XCTAssertFalse(deinitCalls.contains(false), "All leak test targets should be released.")
  }
}
