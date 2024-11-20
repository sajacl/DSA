import XCTest
@testable import DSA

final class MaxHeapTests: XCTestCase {
    func testMinHeap() {
        var heap = MinHeap<Int>()
        
//        // Insert elements
        heap.enqueue(10)
        heap.enqueue(15)
        heap.enqueue(4)
        heap.enqueue(20)
        heap.enqueue(0)
        heap.enqueue(200)
        heap.enqueue(10)
        heap.enqueue(-20)

        XCTAssertTrue(heap.isComplete)

        for amax in heap {
            print(amax)
        }

        debugPrint(heap)

// [-20, 0, 10, 4, 15, 200, 10, 20]

        print(heap.dequeue())
        print(heap)

// [0, 4, 10, 20, 15, 200, 10]

// -20

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [4, 10, 10, 20, 15, 200]

// -20, 0

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [10, 15, 10, 20, 200]

// -20, 0, 4

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [10, 15, 200, 20]

// -20, 0, 4, 10

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [15, 20, 200]

// -20, 0, 4, 10, 10

        XCTAssertTrue(heap.isComplete)

// [20, 200]

// -20, 0, 4, 10, 10, 15
    }

    func testStringMinHeap() {
        var heap = MinHeap<String>()

        heap.enqueue("A")
        heap.enqueue("B")
        heap.enqueue("C")
        heap.enqueue("D")
        heap.enqueue("E")
        heap.enqueue("F")

        print(heap.peek())

        for node in heap {
            print(node)
        }
    }

    /*

        1
       / \
      2   3
     / \ / \
    4  ? 6  7

     */

    func testIsComplete() {
        XCTAssertTrue([1, 2, 3, 4, nil].isCompleteTree)
//        XCTAssertFalse([1, 2, 3, 4, nil, 6, 7].isCompleteTree)
//        XCTAssertFalse([1, nil, 3, 4, nil, 6, 7].isCompleteTree)
//        XCTAssertFalse([1, 2, 3, 4, nil, 6].isCompleteTree)
    }

    // 10, 15, 4, 20, 0

    /*
     [10]
     [10, 4]
     [15, 4, 10]
     [20, 15, 10, 4]
     [20, 15, 10, 4, 0]
     */

    func testMaxHeap() throws {
        var heap = MaxHeap<Int>()
        
        // Insert elements
        heap.enqueue(10)
        heap.enqueue(15)
        heap.enqueue(4)
        heap.enqueue(20)
        heap.enqueue(0)
        heap.enqueue(200)
        heap.enqueue(10)
        heap.enqueue(-20)

        XCTAssertTrue(heap.isComplete)

        for amax in heap {
            print(amax)
        }

        print(heap)

        print(heap.dequeue())
        print(heap)

// [20, 15, 10, 10, 0, 4, -20]

// 200

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [15, 10, 10, -20, 0, 4]

// 200, 20

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [10, 4, 10, -20, 0]

// 200, 20, 15

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [10, 4, 0, -20]

// 200, 20, 15, 10

        XCTAssertTrue(heap.isComplete)
        print(heap.dequeue())
        print(heap)

// [4, -20, 0]

// 200, 20, 15, 10, 10

        XCTAssertTrue(heap.isComplete)

// [-20, 0]

// 200, 20, 15, 10, 10, 4
    }

    func testStringMaxHeap() {
        var heap = MaxHeap<String>()

        heap.enqueue("A")
        heap.enqueue("B")
        heap.enqueue("C")
        heap.enqueue("D")
        heap.enqueue("E")
        heap.enqueue("F")

        print(heap.peek())

        for node in heap {
            print(node)
        }
    }
}

extension MinHeap {
    var isComplete: Bool {
        return Array(self).isCompleteTree
    }
}

extension MaxHeap {
    var isComplete: Bool {
        return Array(self).isCompleteTree
    }
}
