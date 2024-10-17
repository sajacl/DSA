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
        if index < endIndex {
            return self[index]
        }

        return nil
    }
}
