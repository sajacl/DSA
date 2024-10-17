import XCTest
@testable import DSA

final class ArrayTests: XCTestCase {
    func testSwap() {
        var a = [1, 2, 3, 4]

        print(a)

        a.swap(0, 3)

        print(a)
    }

    func testReverse() {
        var a = [1, 2, 3, 4]

        print(a)

//        a._reverse()

        print(a)
    }
}
