import XCTest
@testable import DSA

final class DoublyLinkedListTests: XCTestCase {
    func testAppend() throws {
        let firstNode = DoublyLinkedList.Node(value: 1)
        let secondNode = DoublyLinkedList.Node(value: 2)
        let thirdNode = DoublyLinkedList.Node(value: 3)

        let list = DoublyLinkedList<Int>()

        list.append(firstNode)
        list.append(secondNode)
        list.append(thirdNode)

        print(list.last?.value)
    }

    func testPrepend() throws {
        let list: DoublyLinkedList = [2, 3, 4]

        for value in list {
            print(value)
        }

        print("----------------")
        
        list.prepend(1)

        for value in list {
            print(value)
        }
    }

    func testIteration() throws {
        let list: DoublyLinkedList = [1, 2, 3]

        for value in list {
            print(value)
        }
    }

    func testCount() {
        
    }

    func testRemoveLast() throws {
        let list: DoublyLinkedList = [1, 2, 3]

        for value in list {
            print(value)
        }

        list.removeLast()

        for value in list {
            print(value)
        }
    }

    func testRemoveNode() throws {
        
    }

    private func print(_ value: Any) {
        Swift.print("LinkedList", value)
    }
}
