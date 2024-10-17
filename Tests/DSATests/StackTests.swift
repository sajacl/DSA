import Foundation
import XCTest
@testable import DSA

final class StackTests: XCTestCase {
    func testStack() throws {
        var stack = Stack<String>()

        let _testCase = "X1"
        let _testCase2 = "X2"

        stack.push(_testCase)
        stack.push(_testCase2)

        print(stack)

        XCTAssertEqual(stack.pop(), _testCase2)
        XCTAssertEqual(stack.pop(), _testCase)
    }
}
