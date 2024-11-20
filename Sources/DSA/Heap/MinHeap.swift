import Foundation

struct MinHeap<Element: Comparable> {
    private var storage: [Element] = []

    /// Returns the number of elements in the heap.
    var count: Int {
        return storage.count
    }

    /// Returns the smallest element without removing it.
    func peek() -> Element? {
        return storage.first
    }

    /// Inserts a new element into the heap.
    mutating func enqueue(_ newValue: Element) {
        storage.append(newValue)

        heapifyUp(from: storage.endIndex - 1)

        print(storage)
    }

    private mutating func heapifyUp(from index: Int) {
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

        let lastIndex = storage.endIndex - 1
        let rootIndex = 0

        storage.swapAt(rootIndex, lastIndex)

        let min = storage.removeLast()

        heapifyDown(from: rootIndex)

        print(storage)

        return min
    }

    private mutating func heapifyDown(from index: Int) {
        var currentIndex = index

        while let current = storage[safe: currentIndex] {
            let leftIndex = (currentIndex * 2) + 1
            let rightIndex = (currentIndex * 2) + 2

            if let leftNode = storage[safe: leftIndex], leftNode < current {
                storage.swap(currentIndex, leftIndex)

                currentIndex = leftIndex
            } else if let rightNode = storage[safe: rightIndex], rightNode > current {
                storage.swap(currentIndex, rightIndex)

                currentIndex = rightIndex
            } else {
                break
            }
        }
    }
}
