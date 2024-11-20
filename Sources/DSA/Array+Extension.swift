import Foundation

extension Array {
    // O(1)
    public mutating func swap(_ i: Int, _ j: Int) {
        guard i < j, j < count else {
            return
        }

        let iValue = self[i]

        self[i] = self[j]
        self[j] = iValue
    }

    subscript(safe index: Self.Index) -> Element? {
        if index < count {
            return self[index]
        }

        return nil
    }
}

extension Array {
    var isCompleteTree: Bool {
        return isCompleteBinaryTree(self)
    }

    private func isCompleteBinaryTree<T>(_ array: [T?]) -> Bool {
        var foundNil = false

        for (index, node) in array.enumerated() {
            if node == nil {
                // Once a nil node is found, all subsequent nodes must also be nil
                foundNil = true
                continue
            }

            if foundNil {
                // Found a non-nil node after a nil node, not complete
                return false
            }

            // Additional check: if the node has children, they must be within the array bounds
            let leftChildIndex = 2 * index + 1
            let rightChildIndex = 2 * index + 2

            // If left child index is out of bounds, there should be no children
            if leftChildIndex >= array.count {
                continue
            }

            // If right child exists but left child is nil, it's invalid
            if rightChildIndex < array.count && array[leftChildIndex] == nil {
                return false
            }
        }

        return true
    }
}
