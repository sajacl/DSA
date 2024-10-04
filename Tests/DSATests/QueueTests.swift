import XCTest
@testable import DSA

final class QueueTests: XCTestCase {
    func testQueue() throws {
        var queue = Queue<String>()

        let _testCase = "X1"
        let _testCase2 = "X2"

        queue.enqueue(_testCase)
        queue.enqueue(_testCase2)
        queue.enqueue("X")
        queue.enqueue("Y")

        print(queue)

        XCTAssertEqual(queue.dequeue(), _testCase)
        XCTAssertEqual(queue.dequeue(), _testCase2)
    }

    func testStack() throws {
        var queue = Stack<String>()

        let _testCase = "X1"
        let _testCase2 = "X2"

        queue.push(_testCase)
        queue.push(_testCase2)

        print(queue)

        XCTAssertEqual(queue.pop(), _testCase2)
        XCTAssertEqual(queue.pop(), _testCase)
    }
}
