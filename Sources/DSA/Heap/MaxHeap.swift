import Foundation

struct MaxHeap<Element: Comparable>: Sequence {
    private var storage: [Element]

    init(storage: [Element]) {
        self.storage = storage
    }

    /// Returns the number of elements in the heap.
    var count: Int {
        return storage.count
    }

    /// Returns the largest element without removing it.
    func peek() -> Element? {
        return storage.first
    }

    /// Inserts a new element into the heap.
    mutating func enqueue(_ newValue: Element) {
        storage.append(newValue)

        heapifyUp(from: storage.endIndex - 1)
    }

    /// <#Description#>
    private mutating func heapifyUp(from index: Array<Element>.Index) {
        var currentIndex = index

        while let current = storage[safe: currentIndex] {
            let parentIndex = (currentIndex - 1) / 2

            guard let parent = storage[safe: parentIndex], current > parent else {
                break
            }

            storage.swapAt(currentIndex, parentIndex)

            currentIndex = parentIndex
        }
    }

    mutating func dequeue() -> Element? {
        guard !storage.isEmpty else {
            return nil
        }

        if storage.count == 1 {
            return storage.removeFirst()
        } else {
            let rootIndex = 0

            let max = storage[rootIndex]
            storage[rootIndex] = storage.removeLast()

            heapifyDown(from: rootIndex)

            return max
        }
    }

    private mutating func heapifyDown(from index: Array<Element>.Index) {
        var currentIndex = index

        while let current = storage[safe: currentIndex] {
            let leftIndex = (currentIndex * 2) + 1
            let rightIndex = (currentIndex * 2) + 2

            guard let left = storage[safe: leftIndex] else {
                break
            }

            var maxIndex: Array<Element>.Index? = nil

            if left > current {
                maxIndex = leftIndex
            }

            if let right = storage[safe: rightIndex], right > current, right > left {
                maxIndex = rightIndex
            }

            guard let maxIndex else {
                break
            }

            storage.swapAt(currentIndex, maxIndex)

            currentIndex = maxIndex
        }
    }

    // Sequence

    func makeIterator() -> Iterator {
        Iterator(heap: self)
    }

    struct Iterator: IteratorProtocol {
        private var heap: MaxHeap<Element>

        fileprivate init(heap: MaxHeap<Element>) {
            self.heap = heap
        }

        mutating func next() -> Element? {
            heap.dequeue()
        }
    }
}

extension MaxHeap: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.storage = elements

        for index in stride(from: (storage.count / 2 - 1), through: 0, by: -1) {
            heapifyDown(from: index)
        }
    }
}

extension MaxHeap: Equatable where Element: Equatable {}
extension MaxHeap: Hashable where Element: Hashable {}

extension MaxHeap: CustomStringConvertible {
    var description: String {
        storage.description
    }
}
