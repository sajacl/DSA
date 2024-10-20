import XCTest
@testable import DSA

final class LinkedListTests: XCTestCase {
    func testAppend() throws {
        let firstNode = LinkedList.Node(value: 1)
        let secondNode = LinkedList.Node(value: 2)
        let thirdNode = LinkedList.Node(value: 3)

        let list = LinkedList<Int>()

        list.append(firstNode)
        list.append(secondNode)
        list.append(thirdNode)

        XCTAssertEqual(list.last, thirdNode)
    }

    func testPrepend() throws {
        let list: LinkedList = [2, 3, 4]

        XCTAssertEqual(list.count, 3)

        list.prepend(1)

        XCTAssertEqual(list.head?.value, 1)
    }

    func testIteration() throws {
        let list: LinkedList = [1, 2, 3]

        var _intList: [Int] = []

        for value in list {
            _intList.append(value.value)
        }

        XCTAssertEqual(_intList, [1, 2, 3])
    }

    func testCount() {
        let list: LinkedList = [1, 2, 3]

        print(list.count)

        var indexer = LinkedList.IndexingIterator(list: list)
        
        while let iteration = indexer.next() {
            print("index: \(iteration.index) value: \(iteration.node)")
        }
    }

    func testIndex() {
        let firstNode = LinkedList.Node(value: 1)
        let secondNode = LinkedList.Node(value: 2)
        let thirdNode = LinkedList.Node(value: 3)

        let list = LinkedList<Int>()

        list.append(firstNode)
        list.append(secondNode)
        list.append(thirdNode)

        XCTAssertEqual(list.node(at: 1), secondNode)
    }

    func testInsertAtIndex() {
        let list: LinkedList = [1, 3, 4]

        for value in list {
            print(value)
        }

        let newNode = LinkedList.Node(value: 2)
        list.insert(newNode, at: 1)

        for value in list {
            print(value)
        }
    }

    func testRemoveAtIndex() {
        let list: LinkedList = [1, 2, 3, 4]

        for value in list {
            print(value)
        }

        list.remove(at: 1)

        for value in list {
            print(value)
        }
    }

    func testRemoveLast() throws {
        let list: LinkedList = [1, 2, 3]

        for value in list {
            print(value)
        }

        list.removeLast()

        for value in list {
            print(value)
        }
    }

    func testRemoveNode() throws {
        let firstNode = LinkedList.Node(value: 1)
        let secondNode = LinkedList.Node(value: 2)
        let thirdNode = LinkedList.Node(value: 3)

        let list = LinkedList<Int>()

        list.append(firstNode)
        list.append(secondNode)
        list.append(thirdNode)

        for value in list {
            print(value)
        }

        list.remove(firstNode)

        for value in list {
            print(value)
        }
    }

    private func print(_ value: Any) {
        Swift.print("LinkedList", value)
    }

    func testReverseLinkedList() {
        let linkedList: LinkedList = [1, 2, 3, 4, 5, 6]

        linkedList.reverse()
//        linkedList.rreverse(current: linkedList.head, prev: nil)

        for value in linkedList {
            print(value)
        }
    }
}
