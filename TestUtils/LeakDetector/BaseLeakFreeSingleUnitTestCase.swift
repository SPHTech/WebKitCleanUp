//
//  BaseLeakFreeSingleUnitTestCase.swift
//  TestUtils
//
//  Created by Hoang Nguyen on 18/9/23.
//


import Foundation
import XCTest

/// Detect memory leak for single test object.
/// Example of usage:
/// ```
///  // What you need to do is just to subclass from `BaseLeakFreeSingleUnitTestCase`
///  final class ExampleUnitTest: BaseLeakFreeSingleUnitTestCase<ExampleClass> {
///    func testSomething {
///      // before using sut, initialize it
///      sut = ExampleClass()
///      ...
///      sut.doSomething()
///    }
///  }
/// ```
open class BaseLeakFreeSingleUnitTestCase<Sut: AnyObject>: XCTestCase, TestLeakDetectable {
  public var sut: Sut!

  // MARK: - TestLeakDetectable
  public func targetsForLeakTest() -> [AnyObject] { (sut != nil) ? [sut] : [] }
  public func releaseTargetsBeforeLeakTest() { sut = nil }

  open override func tearDown() {
    performLeakTest()
    super.tearDown()
  }
}
