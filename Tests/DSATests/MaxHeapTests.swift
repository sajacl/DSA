import XCTest
@testable import DSA

final class MaxHeapTests: XCTestCase {
    func testMinHeap() throws {
        // Initialize a MinHeap of integers
        var heap = MinHeap<Int>()
        
        // Insert elements
        heap.enqueue(10)
        heap.enqueue(15)
        heap.enqueue(4)
        heap.enqueue(20)
        heap.enqueue(0)
    }

    func testIsComplete() {
//        print(isCompleteBinaryTree([1, 2, 3, 4, nil]))
//        print(isCompleteBinaryTree([1, 2, 3, 4, nil, 6, 7]))
//        print(isCompleteBinaryTree([1, nil, 3, 4, nil, 6, 7]))
        print(isCompleteBinaryTree([1, 2, 3, 4, nil, 6]))
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
        // Initialize a MinHeap of integers
        var heap = MaxHeap<Int>()
        
        // Insert elements
        heap.enqueue(10)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        heap.enqueue(15)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        heap.enqueue(4)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        heap.enqueue(20)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        heap.enqueue(0)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        heap.enqueue(200)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        heap.enqueue(10)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        heap.enqueue(-20)
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))

        for amax in heap {
            print(amax)
        }

        print(heap.dequeue())
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        print(heap.dequeue())
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        print(heap.dequeue())
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        print(heap.dequeue())
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
        print(heap.dequeue())
        XCTAssertTrue(isCompleteBinaryTree(Array(heap)))
    }
}
