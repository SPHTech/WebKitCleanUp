//
//  ModelTests.swift
//  TestUtilsExampleTests
//
//  Created by Hoang Nguyen on 18/9/23.
//

@testable import TestUtilsExample
import TestUtils
import XCTest

final class ModelTests: BaseLeakFreeSingleUnitTestCase<ChildModel>, XCTestCaseShorthand {
    
    override func setUp() {
        super.setUp()
        let parent = ParentModel(name: "Parrent")
        sut = ChildModel(name: "Child")
        parent.child = sut
        sut.parent = parent
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testModel() {
        let name = when("model get property") { _ -> String in
            sut.name
        }
        
        then("expect to name is equal") {
            XCTAssertEqual(name, "Child")
        }
    }
    
}
