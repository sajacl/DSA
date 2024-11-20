import Foundation

/// A generic MinHeap implementation in Swift.
struct MinHeap<Element: Comparable>: Sequence,
                                     Collection,
                                     RandomAccessCollection,
                                     ExpressibleByArrayLiteral,
                                     CustomStringConvertible {
    private var storage: [Element]

    init(storage: [Element]) {
        self.storage = storage

        for index in stride(from: (storage.count / 2 - 1), through: 0, by: -1) {
            heapifyDown(from: index)
        }
    }

    init(arrayLiteral elements: Element...) {
        self.init(storage: elements)
    }

    /// Returns `true` if the heap is empty.
    var isEmpty: Bool {
        return storage.isEmpty
    }

    /// Returns the number of elements in the heap.
    var count: Int {
        return storage.count
    }

    /// Returns the smallest element without removing it.
    func peek() -> Element? {
        return storage.first
    }

    /// Inserts a new element into the heap.
    mutating func enqueue(_ newElement: Element) {
        storage.append(newElement)

        let lastIndex = storage.endIndex - 1

        heapifyUp(from: lastIndex)
    }

    private mutating func heapifyUp(from index: Array<Element>.Index) {
        var currentIndex = index

        while let current = storage[safe: currentIndex] {
            let parentIndex = (currentIndex - 1) / 2

            guard let parent = storage[safe: parentIndex], current < parent else {
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
            return storage.removeLast()
        } else {
            let rootIndex = 0

            let min = storage[rootIndex]

            storage[rootIndex] = storage.removeLast()

            heapifyDown(from: rootIndex)

            return min
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

            var minIndex: Array<Element>.Index?

            if left < current {
                minIndex = leftIndex
            }

            if let right = storage[safe: rightIndex], right < current, right < left {
                minIndex = rightIndex
            }

            guard let minIndex else {
                break
            }

            storage.swapAt(minIndex, currentIndex)
            currentIndex = minIndex
        }
    }

    // Sequence

    func makeIterator() -> Iterator {
        Iterator(heap: self)
    }

    struct Iterator: IteratorProtocol {
        private var heap: MinHeap<Element>

        fileprivate init(heap: MinHeap<Element>) {
            self.heap = heap
        }

        mutating func next() -> Element? {
            heap.dequeue()
        }
    }

    // Collection

    var startIndex: Array<Element>.Index {
        storage.startIndex
    }

    var endIndex: Array<Element>.Index {
        storage.endIndex
    }

    subscript(position: Array<Element>.Index) -> Element {
        storage[position]
    }

    func index(after i: Array<Element>.Index) -> Int {
        storage.index(after: i)
    }

    // CustomStringConvertible

    var description: String {
        storage.description
    }
}

extension MinHeap: Equatable where Element: Equatable {}
extension MinHeap: Hashable where Element: Hashable {}
